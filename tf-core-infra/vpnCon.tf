resource "random_password" "vpnPsk" {
  for_each = {
    for vpn in var.vpnConfiguration :
    vpn.name => vpn
  }

  length           = 24
  special          = true
  override_special = "!-_="

  keepers = {
    service_principal = azurerm_local_network_gateway.vpnLng[each.key].id
  }
}

resource "azurerm_key_vault_secret" "vpnPskKvSecret" {
  for_each = {
    for vpn in var.vpnConfiguration :
    vpn.name => vpn
  }

  name = "con-vpn-${var.environmentShort}-${var.locationShort}-${var.commonName}-${each.key}"
  value = jsonencode({
    shared_key = random_password.vpnPsk[each.key].result
  })
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_local_network_gateway" "vpnLng" {
  for_each = {
    for vpn in var.vpnConfiguration :
    vpn.name => vpn
  }

  name                = "lng-vpn-${var.environmentShort}-${var.locationShort}-${var.commonName}-${each.key}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  gateway_address = each.value.remoteGatewayIp
  address_space   = each.value.remoteSubnets
}

resource "azurerm_virtual_network_gateway_connection" "vpnCon" {
  for_each = {
    for vpn in var.vpnConfiguration :
    vpn.name => vpn
  }

  name                = "con-vpn-${var.environmentShort}-${var.locationShort}-${var.commonName}-${each.key}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpnGw.id
  local_network_gateway_id   = azurerm_local_network_gateway.vpnLng[each.key].id
  shared_key                 = random_password.vpnPsk[each.key].result
}
