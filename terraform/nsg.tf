resource "azurerm_network_security_group" "nsg" {
  count               = length(var.vnetConfig.subnets)
  name                = "nsg-${var.environmentShort}-${var.locationShort}-${var.commonName}-${var.vnetConfig.subnets[count.index].name}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "nsgAssociations" {
  count                     = length(var.vnetConfig.subnets)
  subnet_id                 = azurerm_subnet.subnet[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg[count.index].id
}