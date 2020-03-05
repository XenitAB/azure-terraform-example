resource "azuread_application" "delegateKvAadApp" {
  for_each = {
    for rg in var.rgConfig :
    rg.commonName => rg
    if rg.delegateKv == true
  }

  name = "sp-rg-${var.commonName}-${var.environmentShort}-${each.value.commonName}-kvreader"
}

resource "azuread_service_principal" "delegateKvAadSp" {
  for_each = {
    for rg in var.rgConfig :
    rg.commonName => rg
    if rg.delegateKv == true
  }

  application_id = azuread_application.delegateKvAadApp[each.key].application_id
}

resource "random_password" "delegateKvAadSpSecret" {
  for_each = {
    for rg in var.rgConfig :
    rg.commonName => rg
    if rg.delegateKv == true
  }

  length           = 24
  special          = true
  override_special = "!-_="

  keepers = {
    service_principal = azuread_service_principal.delegateKvAadSp[each.key].id
  }
}

resource "azuread_application_password" "delegateKvAadSpSecret" {
  for_each = {
    for rg in var.rgConfig :
    rg.commonName => rg
    if rg.delegateKv == true
  }

  application_object_id = azuread_application.delegateKvAadApp[each.key].id
  value                 = random_password.delegateKvAadSpSecret[each.key].result
  end_date              = timeadd(timestamp(), "87600h") # 10 years

  lifecycle {
    ignore_changes = [
      end_date
    ]
  }
}

resource "azurerm_key_vault_secret" "delegateKvAadSpKvSecretClientId" {
  for_each = {
    for rg in var.rgConfig :
    rg.commonName => rg
    if rg.delegateKv == true
  }

  name         = "keyvault-credentials-clientid"
  value        = azuread_service_principal.delegateKvAadSp[each.key].application_id
  key_vault_id = azurerm_key_vault.delegateKv[each.key].id

  depends_on = [
    azurerm_key_vault_access_policy.delegateKvApKvreaderSp
  ]
}

resource "azurerm_key_vault_secret" "delegateKvAadSpKvSecretClientSecret" {
  for_each = {
    for rg in var.rgConfig :
    rg.commonName => rg
    if rg.delegateKv == true
  }

  name         = "keyvault-credentials-clientsecret"
  value        = random_password.delegateKvAadSpSecret[each.key].result
  key_vault_id = azurerm_key_vault.delegateKv[each.key].id

  depends_on = [
    azurerm_key_vault_access_policy.delegateKvApKvreaderSp
  ]
}

resource "azurerm_key_vault_secret" "delegateKvAadSpKvSecretKeyVaultName" {
  for_each = {
    for rg in var.rgConfig :
    rg.commonName => rg
    if rg.delegateKv == true
  }

  name         = "keyvault-credentials-keyvaultname"
  value        = "kv-${var.environmentShort}-${var.locationShort}-${each.key}"
  key_vault_id = azurerm_key_vault.delegateKv[each.key].id

  depends_on = [
    azurerm_key_vault_access_policy.delegateKvApKvreaderSp
  ]
}
