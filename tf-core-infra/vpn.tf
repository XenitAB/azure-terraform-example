resource "azurerm_public_ip" "pipVpnGw1" {
  name                = "pip-${var.environmentShort}-${var.locationShort}-${var.commonName}-vpngw1"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "Standard"
  allocation_method   = "Static"
}

resource "azurerm_public_ip" "pipVpnGw2" {
  name                = "pip-${var.environmentShort}-${var.locationShort}-${var.commonName}-vpngw2"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "Standard"
  allocation_method   = "Static"
}

resource "azurerm_virtual_network_gateway" "vpnGw" {
  name                = "vpn-${var.environmentShort}-${var.locationShort}-${var.commonName}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  type          = "Vpn"
  vpn_type      = "RouteBased"
  active_active = true
  enable_bgp    = false
  sku           = "VpnGw2AZ"

  ip_configuration {
    name                          = "ipconfig-1"
    public_ip_address_id          = azurerm_public_ip.pipVpnGw1.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gatewaySubnet.id
  }

  ip_configuration {
    name                          = "ipconfig-2"
    public_ip_address_id          = azurerm_public_ip.pipVpnGw2.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gatewaySubnet.id
  }
}
