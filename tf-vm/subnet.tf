data "azurerm_subnet" "subnet" {
  name                 = "sn-${var.environmentShort}-${var.locationShort}-${var.coreConfig.commonName}-${var.coreConfig.subnetName}"
  virtual_network_name = "vnet-${var.environmentShort}-${var.locationShort}-${var.coreConfig.commonName}"
  resource_group_name  = "rg-${var.environmentShort}-${var.locationShort}-${var.coreConfig.commonName}"
}
