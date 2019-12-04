data "azurerm_subscription" "current" {}

resource "azurerm_container_registry" "acr" {
  name                = "acr${var.environmentShort}${var.locationShort}${var.commonName}"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = false
}

resource "azurerm_role_assignment" "roleAssignmentAcrPull" {
  scope                = "${data.azurerm_subscription.current.id}/resourceGroups/${data.azurerm_resource_group.rg.name}"
  role_definition_name = "AcrPull"
  principal_id         = azuread_service_principal.aadAppAksClient.id
}
