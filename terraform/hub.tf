# Create a resource group
resource "azurerm_resource_group" "rg-hub" {
  name     = "rg-${var.environmentShort}-${var.locationShort}-hub"
  location = var.location
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet-hub" {
  name                = "vnet-${var.environmentShort}-${var.locationShort}-hub"
  resource_group_name = azurerm_resource_group.rg-hub.name
  location            = azurerm_resource_group.rg-hub.location
  address_space       = var.vnetConfig["hub"].addressSpace
}