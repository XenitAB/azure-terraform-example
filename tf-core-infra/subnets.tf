resource "azurerm_subnet" "normalSubnet" {
  for_each = {
    for subnet in var.vnetConfig.subnets :
    subnet.name => subnet
    if subnet.aksSubnet == false
  }
  name                      = "sn-${var.environmentShort}-${var.locationShort}-${var.commonName}-${each.value.name}"
  resource_group_name       = data.azurerm_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.vnet.name
  address_prefix            = each.value.cidr
  network_security_group_id = azurerm_network_security_group.nsg[each.value.name].id
}

resource "azurerm_subnet" "subnet" {
  for_each = {
    for subnet in var.vnetConfig.subnets :
    subnet.name => subnet
    if subnet.aksSubnet == true
  }
  name                 = "sn-${var.environmentShort}-${var.locationShort}-${var.commonName}-${each.value.name}"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = each.value.cidr

  lifecycle {
    ignore_changes = [
      route_table_id
    ]
  }
}
