# resource "azurerm_kubernetes_cluster" "aks" {
#   name                = "aks-${var.environmentShort}-${var.locationShort}-${var.commonName}"
#   location            = data.azurerm_resource_group.rg.location
#   resource_group_name = data.azurerm_resource_group.rg.name
#   dns_prefix          = "aks-${var.environmentShort}-${var.locationShort}-${var.commonName}"

#   default_node_pool {
#     name                = "default"
#     node_count          = 1
#     vm_size             = "Standard_D2_v2"
#     availability_zones  = [
#         "1",
#         "2",
#         "3"
#     ]
#     enable_auto_scaling = false
#     type                = "VirtualMachineScaleSets"
#   }

#   service_principal {
#     client_id     = data.azuread_service_principal.aadSp.object_id
#     client_secret = data.azurerm_key_vault_secret.kvSecret.value
#   }
# }