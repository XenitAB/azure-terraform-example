# Create a resource group
resource "azurerm_resource_group" "rg-spoke1" {
  name     = "rg-${var.environmentShort}-${var.locationShort}-spoke1"
  location = var.location
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet-spoke1" {
  name                = "vnet-${var.environmentShort}-${var.locationShort}-spoke1"
  resource_group_name = azurerm_resource_group.rg-spoke1.name
  location            = azurerm_resource_group.rg-spoke1.location
  address_space       = var.vnetConfig["spoke1"].addressSpace
}