resource "azurerm_subnet" "subnet" {
  for_each                    = {for subnet in var.vnetConfig.subnets: subnet.name => subnet}
  name                        = "sn-${var.environmentShort}-${var.locationShort}-${var.commonName}-${each.value.name}"
  resource_group_name         = data.azurerm_resource_group.rg.name
  virtual_network_name        = azurerm_virtual_network.vnet.name
  address_prefix              = each.value.cidr
}

resource "azurerm_subnet" "gwSubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.gatewaySubnet
}