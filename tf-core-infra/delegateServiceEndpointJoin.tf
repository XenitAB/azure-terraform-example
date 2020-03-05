resource "azurerm_role_definition" "roleServiceEndpointJoin" {
  name  = "role-${var.environmentShort}-${var.locationShort}-${var.commonName}-serviceEndpointJoin"
  scope = azurerm_virtual_network.vnet.id

  permissions {
    actions     = ["Microsoft.Network/virtualNetworks/subnets/joinViaServiceEndpoint/action"]
    not_actions = []
  }

  assignable_scopes = [
    azurerm_virtual_network.vnet.id
  ]
}

data "azuread_group" "aadGroupServiceEndpointJoin" {
  name = "azr-${var.groupCommonName}-${var.environmentShort}-serviceEndpointJoin"
}

resource "azurerm_role_assignment" "assignmentServiceEndpointJoin" {
  scope              = azurerm_virtual_network.vnet.id
  role_definition_id = azurerm_role_definition.roleServiceEndpointJoin.id
  principal_id       = data.azuread_group.aadGroupServiceEndpointJoin.id
}
