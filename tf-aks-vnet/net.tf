data "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.environmentShort}-${var.locationShort}-${var.coreCommonName}"
  resource_group_name = "rg-${var.environmentShort}-${var.locationShort}-${var.coreCommonName}"
}

data "azurerm_subnet" "subnet" {
  name                 = "sn-${var.environmentShort}-${var.locationShort}-${var.coreCommonName}-${var.commonName}"
  virtual_network_name = "vnet-${var.environmentShort}-${var.locationShort}-${var.coreCommonName}"
  resource_group_name  = "rg-${var.environmentShort}-${var.locationShort}-${var.coreCommonName}"
}

resource "azurerm_role_assignment" "vnetAssignment" {
  scope                = data.azurerm_virtual_network.vnet.id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.aadAppAksClient.object_id
}
