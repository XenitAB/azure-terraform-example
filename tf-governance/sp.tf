resource "azuread_application" "aadApp" {
  for_each = { for rg in var.rgConfig : rg.commonName => rg }
  name     = "sp-rg-${var.commonName}-${var.environmentShort}-${each.value.commonName}-contributor"
}

resource "azuread_service_principal" "aadSp" {
  for_each       = { for rg in var.rgConfig : rg.commonName => rg }
  application_id = azuread_application.aadApp[each.key].application_id
}

resource "azurerm_role_assignment" "roleAssignmentSp" {
  for_each             = { for rg in var.rgConfig : rg.commonName => rg }
  scope                = azurerm_resource_group.rg[each.key].id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.aadSp[each.key].object_id
}

resource "random_password" "aadSpSecret" {
  for_each         = { for rg in var.rgConfig : rg.commonName => rg }
  length           = 24
  special          = true
  override_special = "!-_="

  keepers = {
    service_principal = azuread_service_principal.aadSp[each.key].id
  }
}

resource "azuread_application_password" "aadSpSecret" {
  for_each              = { for rg in var.rgConfig : rg.commonName => rg }
  application_object_id = azuread_application.aadApp[each.key].id
  value                 = random_password.aadSpSecret[each.key].result
  end_date              = timeadd(timestamp(), "87600h") # 10 years

  lifecycle {
    ignore_changes = [
      end_date
    ]
  }
}

resource "azurerm_key_vault_secret" "aadSpKvSecret" {
  for_each = {
    for rg in var.rgConfig :
    rg.commonName => rg
  }
  name = azuread_service_principal.aadSp[each.key].display_name
  value = jsonencode({
    tenantId       = data.azurerm_subscription.current.tenant_id
    subscriptionId = data.azurerm_subscription.current.subscription_id
    clientId       = azuread_service_principal.aadSp[each.key].application_id
    clientSecret   = random_password.aadSpSecret[each.key].result
  })
  key_vault_id = data.azurerm_key_vault.coreKv.id
}
