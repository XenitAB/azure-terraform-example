package terraform.analysis

input_create_azuread_group = {
  "resource_changes": [
    {
      "change": {
        "actions": [
          "create"
        ]
      },
      "type": "azuread_group"
    }
  ]
}

input_delete_azuread_group = {
  "resource_changes": [
    {
      "change": {
        "actions": [
          "delete"
        ]
      },
      "type": "azuread_group"
    }
  ]
}

input_update_azuread_group = {
  "resource_changes": [
    {
      "change": {
        "actions": [
          "update"
        ]
      },
      "type": "azuread_group"
    }
  ]
}

test_create_azuread_group {
    authz with input as input_create_azuread_group
}

test_delete_azuread_group {
    not authz with input as input_delete_azuread_group
}

test_update_azuread_group {
    authz with input as input_update_azuread_group
}