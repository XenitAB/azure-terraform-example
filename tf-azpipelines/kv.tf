data "azurerm_key_vault" "kv" {
  name                = "kv-${var.environmentShort}-${var.locationShort}-${var.coreConfig.commonName}"
  resource_group_name = "rg-${var.environmentShort}-${var.locationShort}-${var.coreConfig.commonName}"
}

data "azurerm_key_vault_secret" "kvSecretAzurePipelinesAgent" {
  name         = "azure-pipelines-agent-credentials"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "kvSecretAzpAgent" {
  name         = "azure-pipelines-agent-outboundip"
  value        = azurerm_public_ip.pip.ip_address
  key_vault_id = data.azurerm_key_vault.kv.id
}
