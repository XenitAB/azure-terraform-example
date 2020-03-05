# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.environmentShort}-${var.locationShort}-${var.commonName}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  address_space       = var.vnetConfig.addressSpace
}

resource "azurerm_virtual_network_peering" "peeringHub" {
  name                         = "peering-${var.environmentShort}-${var.locationShort}-${var.commonName}-hub"
  resource_group_name          = data.azurerm_resource_group.rg.name
  virtual_network_name         = azurerm_virtual_network.vnet.name
  remote_virtual_network_id    = var.hubVnetId
  allow_forwarded_traffic      = true
  use_remote_gateways          = false
  allow_virtual_network_access = true
}
