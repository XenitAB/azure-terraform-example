resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.environmentShort}-${var.locationShort}-${var.commonName}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = "aks-${var.environmentShort}-${var.locationShort}-${var.commonName}"
  kubernetes_version  = "1.15.7"

  default_node_pool {
    name       = "default"
    node_count = 3
    max_count  = 10
    min_count  = 2
    vm_size    = "Standard_D2_v2"
    availability_zones = [
      "1",
      "2",
      "3"
    ]
    enable_auto_scaling = true
    type                = "VirtualMachineScaleSets"
    vnet_subnet_id      = data.azurerm_subnet.subnet.id
  }

  network_profile {
    network_plugin    = "kubenet"
    network_policy    = "calico"
    load_balancer_sku = "standard"
  }

  service_principal {
    client_id     = azuread_application.aadAppAksClient.application_id
    client_secret = azuread_application_password.aadAppAksClient.value
  }

  role_based_access_control {
    enabled = true

    azure_active_directory {
      client_app_id     = azuread_application.aadAppAksClient.application_id
      server_app_id     = azuread_application.aadAppAksServer.application_id
      server_app_secret = azuread_application_password.aadAppAksServer.value
    }
  }

  linux_profile {
    admin_username = "aksadmin"
    ssh_key {
      key_data = tls_private_key.sshKey.public_key_openssh
    }
  }

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count
    ]
  }

  depends_on = [
    azurerm_role_assignment.vnetAssignment
  ]
}

data "azurerm_public_ip" "aksOutboundPips" {
  for_each = {
    for pip in azurerm_kubernetes_cluster.aks.network_profile[0].load_balancer_profile[0].effective_outbound_ips :
    split("/", pip)[8] => {
      name                = split("/", pip)[8]
      resource_group_name = split("/", pip)[4]
    }
  }
  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}
