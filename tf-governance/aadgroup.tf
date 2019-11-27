# AAD Group for Owners
resource "azuread_group" "aadGroupOwner" {
    for_each    = {for rg in var.rgConfig: rg.commonName => rg}
    name        = "aad-sec-u-${var.environmentShort}-${each.value.commonName}-owner"
}

resource "azurerm_role_assignment" "roleAssignmentOwner" {
    for_each             = {for rg in var.rgConfig: rg.commonName => rg}
    scope                = azurerm_resource_group.rg[each.key].id
    role_definition_name = "Owner"
    principal_id         = azuread_group.aadGroupOwner[each.key].id
}

# AAD Group for Contributors
resource "azuread_group" "aadGroupContributor" {
    for_each    = {for rg in var.rgConfig: rg.commonName => rg}
    name        = "aad-sec-u-${var.environmentShort}-${each.value.commonName}-contributor"
}

resource "azurerm_role_assignment" "roleAssignmentContributor" {
    for_each             = {for rg in var.rgConfig: rg.commonName => rg}
    scope                = azurerm_resource_group.rg[each.key].id
    role_definition_name = "Contributor"
    principal_id         = azuread_group.aadGroupContributor[each.key].id
}

# AAD Group for Readers
resource "azuread_group" "aadGroupReader" {
    for_each    = {for rg in var.rgConfig: rg.commonName => rg}
    name        = "aad-sec-u-${var.environmentShort}-${each.value.commonName}-reader"
}

resource "azurerm_role_assignment" "roleAssignmentReader" {
    for_each             = {for rg in var.rgConfig: rg.commonName => rg}
    scope                = azurerm_resource_group.rg[each.key].id
    role_definition_name = "Reader"
    principal_id         = azuread_group.aadGroupReader[each.key].id
}