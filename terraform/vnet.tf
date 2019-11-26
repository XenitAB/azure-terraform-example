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

  dynamic "subnet" {
    for_each = [for s in var.vnetConfig.subnets: {
      subnetName      = "sn-${var.environmentShort}-${var.locationShort}-${var.commonName}-${s.name}"
      prefix          = s.cidr
      nsgName         = "nsg-${var.environmentShort}-${var.locationShort}-${var.commonName}-${s.name}"
    }]

    content {
      name           = subnet.value.subnetName
      address_prefix = subnet.value.prefix
      security_group = subnet.value.nsgName
    }
  }
}

resource "azurerm_subnet" "gwSubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.gatewaySubnet
}