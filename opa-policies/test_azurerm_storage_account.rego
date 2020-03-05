package terraform.analysis

input_create_azurerm_storage_account = {
  "resource_changes": [
    {
      "change": {
        "actions": [
          "create"
        ]
      },
      "type": "azurerm_storage_account"
    }
  ]
}

input_delete_azurerm_storage_account = {
  "resource_changes": [
    {
      "change": {
        "actions": [
          "delete"
        ]
      },
      "type": "azurerm_storage_account"
    }
  ]
}

input_update_azurerm_storage_account = {
  "resource_changes": [
    {
      "change": {
        "actions": [
          "update"
        ]
      },
      "type": "azurerm_storage_account"
    }
  ]
}

test_create_azurerm_storage_account {
    authz with input as input_create_azurerm_storage_account
}

test_delete_azurerm_storage_account {
    not authz with input as input_delete_azurerm_storage_account
}

test_update_azurerm_storage_account {
    authz with input as input_update_azurerm_storage_account
}