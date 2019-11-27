resource "azurerm_network_security_group" "nsg" {
  for_each            = {for subnet in var.vnetConfig.subnets: subnet.name => subnet}
  name                = "nsg-${var.environmentShort}-${var.locationShort}-${var.commonName}-${each.value.name}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "nsgAssociations" {
  for_each                  = {for subnet in var.vnetConfig.subnets: subnet.name => subnet}
  subnet_id                 = azurerm_subnet.subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}