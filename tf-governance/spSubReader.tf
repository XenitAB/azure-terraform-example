resource "azuread_application" "aadSubReaderApp" {
  name = "sp-sub-${var.commonName}-${var.environmentShort}-reader"
}

resource "azuread_service_principal" "aadSubReaderSp" {
  application_id = azuread_application.aadSubReaderApp.application_id
}

resource "azurerm_role_assignment" "roleAssignmentSubReaderSp" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Reader"
  principal_id         = azuread_service_principal.aadSubReaderSp.object_id
}

resource "random_password" "aadSubReaderSpSecret" {
  length           = 24
  special          = true
  override_special = "!-_="

  keepers = {
    service_principal = azuread_service_principal.aadSubReaderSp.id
  }
}

resource "azuread_application_password" "aadSubReaderSpSecret" {
  application_object_id = azuread_application.aadSubReaderApp.id
  value                 = random_password.aadSubReaderSpSecret.result
  end_date              = timeadd(timestamp(), "87600h") # 10 years

  lifecycle {
    ignore_changes = [
      end_date
    ]
  }
}

resource "azurerm_key_vault_secret" "aadSubReaderSpKvSecret" {
  name = azuread_service_principal.aadSubReaderSp.display_name
  value = jsonencode({
    tenantId       = data.azurerm_subscription.current.tenant_id
    subscriptionId = data.azurerm_subscription.current.subscription_id
    clientId       = azuread_service_principal.aadSubReaderSp.application_id
    clientSecret   = random_password.aadSubReaderSpSecret.result
  })
  key_vault_id = data.azurerm_key_vault.coreKv.id
}
