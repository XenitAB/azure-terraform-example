data "azurerm_key_vault" "coreKv" {
  name                = "kv-${var.environmentShort}-${var.locationShort}-${var.coreCommonName}"
  resource_group_name = "rg-${var.environmentShort}-${var.locationShort}-${var.coreCommonName}"
}
