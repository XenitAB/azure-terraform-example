resource "azurerm_subnet" "subnet" {
  for_each = {
    for subnet in var.vnetConfig.subnets :
    subnet.name => subnet
    if subnet.aksSubnet == false
  }
  name                 = "sn-${var.environmentShort}-${var.locationShort}-${var.commonName}-${each.value.name}"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = each.value.cidr
  service_endpoints    = each.value.service_endpoints
}

resource "azurerm_subnet" "subnetAks" {
  for_each = {
    for subnet in var.vnetConfig.subnets :
    subnet.name => subnet
    if subnet.aksSubnet == true
  }
  name                 = "sn-${var.environmentShort}-${var.locationShort}-${var.commonName}-${each.value.name}"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = each.value.cidr
  service_endpoints    = each.value.service_endpoints
}

resource "azurerm_subnet" "gatewaySubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.gatewaySubnet
}
