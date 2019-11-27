# AAD Group for Owners
resource "azuread_group" "aadGroupOwner" {
    count     = length(var.rgConfig)
    name    = "aad-sec-u-${var.environmentShort}-${var.rgConfig[count.index].commonName}-owner"
}

resource "azurerm_role_assignment" "roleAssignmentOwner" {
    count                = length(var.rgConfig)
    scope                = azurerm_resource_group.rg[count.index].id
    role_definition_name = "Owner"
    principal_id         = azuread_group.aadGroupOwner[count.index].id
}

# AAD Group for Contributors
resource "azuread_group" "aadGroupContributor" {
    count     = length(var.rgConfig)
    name    = "aad-sec-u-${var.environmentShort}-${var.rgConfig[count.index].commonName}-contributor"
}

resource "azurerm_role_assignment" "roleAssignmentContributor" {
    count                = length(var.rgConfig)
    scope                = azurerm_resource_group.rg[count.index].id
    role_definition_name = "Contributor"
    principal_id         = azuread_group.aadGroupContributor[count.index].id
}

# AAD Group for Readers
resource "azuread_group" "aadGroupReader" {
    count     = length(var.rgConfig)
    name    = "aad-sec-u-${var.environmentShort}-${var.rgConfig[count.index].commonName}-reader"
}

resource "azurerm_role_assignment" "roleAssignmentReader" {
    count                = length(var.rgConfig)
    scope                = azurerm_resource_group.rg[count.index].id
    role_definition_name = "Reader"
    principal_id         = azuread_group.aadGroupReader[count.index].id
}