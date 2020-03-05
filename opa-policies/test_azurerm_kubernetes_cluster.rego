package terraform.analysis

input_create_azurerm_kubernetes_cluster = {
  "resource_changes": [
    {
      "change": {
        "actions": [
          "create"
        ]
      },
      "type": "azurerm_kubernetes_cluster"
    }
  ]
}

input_delete_azurerm_kubernetes_cluster = {
  "resource_changes": [
    {
      "change": {
        "actions": [
          "delete"
        ]
      },
      "type": "azurerm_kubernetes_cluster"
    }
  ]
}

input_update_azurerm_kubernetes_cluster = {
  "resource_changes": [
    {
      "change": {
        "actions": [
          "update"
        ]
      },
      "type": "azurerm_kubernetes_cluster"
    }
  ]
}

test_create_azurerm_kubernetes_cluster {
    authz with input as input_create_azurerm_kubernetes_cluster
}

test_delete_azurerm_kubernetes_cluster {
    not authz with input as input_delete_azurerm_kubernetes_cluster
}

test_update_azurerm_kubernetes_cluster {
    authz with input as input_update_azurerm_kubernetes_cluster
}