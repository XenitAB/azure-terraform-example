data "azurerm_subnet" "insideSubnet" {
  name                 = "sn-${var.environmentShort}-${var.locationShort}-${var.coreConfig.commonName}-${var.coreConfig.insideSubnetName}"
  virtual_network_name = "vnet-${var.environmentShort}-${var.locationShort}-${var.coreConfig.commonName}"
  resource_group_name  = "rg-${var.environmentShort}-${var.locationShort}-${var.coreConfig.commonName}"
}

data "azurerm_subnet" "outsideSubnet" {
  name                 = "sn-${var.environmentShort}-${var.locationShort}-${var.coreConfig.commonName}-${var.coreConfig.outsideSubnetName}"
  virtual_network_name = "vnet-${var.environmentShort}-${var.locationShort}-${var.coreConfig.commonName}"
  resource_group_name  = "rg-${var.environmentShort}-${var.locationShort}-${var.coreConfig.commonName}"
}

data "azurerm_subnet" "managementSubnet" {
  name                 = "sn-${var.environmentShort}-${var.locationShort}-${var.coreConfig.commonName}-${var.coreConfig.managementSubnetName}"
  virtual_network_name = "vnet-${var.environmentShort}-${var.locationShort}-${var.coreConfig.commonName}"
  resource_group_name  = "rg-${var.environmentShort}-${var.locationShort}-${var.coreConfig.commonName}"
}
