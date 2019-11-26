# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "rg-${var.environmentShort}-${var.locationShort}-${var.commonName}"
  location = var.location
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.environmentShort}-${var.locationShort}-${var.commonName}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = var.vnetConfig.addressSpace
}