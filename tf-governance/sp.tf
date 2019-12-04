resource "azuread_application" "aadApp" {
  for_each = { for rg in var.rgConfig : rg.commonName => rg }
  name     = "sp-rg-${var.environmentShort}-${each.value.commonName}-contributor"
}

resource "azuread_service_principal" "aadSp" {
  for_each       = { for rg in var.rgConfig : rg.commonName => rg }
  application_id = azuread_application.aadApp[each.key].application_id
}

resource "azurerm_role_assignment" "roleAssignmentSp" {
  for_each             = { for rg in var.rgConfig : rg.commonName => rg }
  scope                = azurerm_resource_group.rg[each.key].id
  role_definition_name = "Contributor"
  principal_id         = azuread_service_principal.aadSp[each.key].object_id
}
