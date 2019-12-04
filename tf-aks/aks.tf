resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.environmentShort}-${var.locationShort}-${var.commonName}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = "aks-${var.environmentShort}-${var.locationShort}-${var.commonName}"
  kubernetes_version  = "1.14.8"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
    availability_zones = [
      "1",
      "2",
      "3"
    ]
    enable_auto_scaling = false
    type                = "VirtualMachineScaleSets"
  }

  network_profile {
    network_plugin    = "kubenet"
    network_policy    = "calico"
    load_balancer_sku = "standard"
  }

  service_principal {
    client_id     = azuread_application.aksSp.application_id
    client_secret = azuread_service_principal_password.aksSp.value
  }

  role_based_access_control {
    enabled = true

    azure_active_directory {
      client_app_id     = azuread_application.aadAppAksClient.application_id
      server_app_id     = azuread_application.aadAppAksServer.application_id
      server_app_secret = azuread_service_principal_password.aadAppAksServer.value
    }
  }
}
