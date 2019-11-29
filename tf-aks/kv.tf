data "azurerm_key_vault" "kv" {
  name = "kv-${var.environmentShort}-${var.locationShort}-${var.coreInfraCommonName}"
  resource_group_name = data.azurerm_resource_group.coreInfraRg.name
}

data "azurerm_key_vault_secret" "kvSecret" {
  name         = "sp-${var.environmentShort}-${var.commonName}-contributor"
  key_vault_id = data.azurerm_key_vault.kv.id
}