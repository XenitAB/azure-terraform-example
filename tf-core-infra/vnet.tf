# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.environmentShort}-${var.locationShort}-${var.commonName}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  address_space       = var.vnetConfig.addressSpace
}
