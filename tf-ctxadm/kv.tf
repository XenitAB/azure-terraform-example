data "azurerm_key_vault" "kv" {
  name                = "kv-${var.environmentShort}-${var.locationShort}-${var.coreConfig.commonName}"
  resource_group_name = "rg-${var.environmentShort}-${var.locationShort}-${var.coreConfig.commonName}"
}
