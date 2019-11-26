resource "azurerm_subnet" "subnet" {
  count                       = length(var.vnetConfig.subnets)
  name                        = "sn-${var.environmentShort}-${var.locationShort}-${var.commonName}-${var.vnetConfig.subnets[count.index].name}"
  resource_group_name         = azurerm_resource_group.rg.name
  virtual_network_name        = azurerm_virtual_network.vnet.name
  address_prefix              = var.vnetConfig.subnets[count.index].cidr
}

resource "azurerm_subnet" "gwSubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.gatewaySubnet
}