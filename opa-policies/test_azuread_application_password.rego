package terraform.analysis

input_create_azuread_application_password = {
  "resource_changes": [
    {
      "change": {
        "actions": [
          "create"
        ]
      },
      "type": "azuread_application_password"
    }
  ]
}

input_delete_azuread_application_password = {
  "resource_changes": [
    {
      "change": {
        "actions": [
          "delete"
        ]
      },
      "type": "azuread_application_password"
    }
  ]
}

input_update_azuread_application_password = {
  "resource_changes": [
    {
      "change": {
        "actions": [
          "update"
        ]
      },
      "type": "azuread_application_password"
    }
  ]
}

test_create_azuread_application_password {
    authz with input as input_create_azuread_application_password
}

test_delete_azuread_application_password {
    not authz with input as input_delete_azuread_application_password
}

test_update_azuread_application_password {
    not authz with input as input_update_azuread_application_password
}