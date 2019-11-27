# data "azurerm_subscription" "azureSubscription" {}

resource "azuread_group" "aadgroup" {
    count     = length(var.rgConfig)
    name    = "aad-sec-u-${var.environmentShort}-${var.rgConfig[count.index].commonName}"
}

# resource "azurerm_role_assignment" "example" {
#   scope                = "${data.azurerm_subscription.primary.id}"
#   role_definition_name = "Reader"
#   principal_id         = "${data.azurerm_client_config.example.service_principal_object_id}"
# }