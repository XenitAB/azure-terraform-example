package terraform.analysis

input_create_kubernetes_namespace = {
  "resource_changes": [
    {
      "change": {
        "actions": [
          "create"
        ]
      },
      "type": "kubernetes_namespace"
    }
  ]
}

input_delete_kubernetes_namespace = {
  "resource_changes": [
    {
      "change": {
        "actions": [
          "delete"
        ]
      },
      "type": "kubernetes_namespace"
    }
  ]
}

input_update_kubernetes_namespace = {
  "resource_changes": [
    {
      "change": {
        "actions": [
          "update"
        ]
      },
      "type": "kubernetes_namespace"
    }
  ]
}

test_create_kubernetes_namespace {
    authz with input as input_create_kubernetes_namespace
}

test_delete_kubernetes_namespace {
    not authz with input as input_delete_kubernetes_namespace
}

test_update_kubernetes_namespace {
    authz with input as input_update_kubernetes_namespace
}