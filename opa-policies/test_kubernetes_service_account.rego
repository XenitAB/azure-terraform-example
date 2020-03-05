package terraform.analysis

input_create_kubernetes_service_account = {
  "resource_changes": [
    {
      "change": {
        "actions": [
          "create"
        ]
      },
      "type": "kubernetes_service_account"
    }
  ]
}

input_delete_kubernetes_service_account = {
  "resource_changes": [
    {
      "change": {
        "actions": [
          "delete"
        ]
      },
      "type": "kubernetes_service_account"
    }
  ]
}

input_update_kubernetes_service_account = {
  "resource_changes": [
    {
      "change": {
        "actions": [
          "update"
        ]
      },
      "type": "kubernetes_service_account"
    }
  ]
}

test_create_kubernetes_service_account {
    authz with input as input_create_kubernetes_service_account
}

test_delete_kubernetes_service_account {
    not authz with input as input_delete_kubernetes_service_account
}

test_update_kubernetes_service_account {
    authz with input as input_update_kubernetes_service_account
}