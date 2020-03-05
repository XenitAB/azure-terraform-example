package terraform.analysis

input_create_azurerm_virtual_machine = {
  "resource_changes": [
    {
      "change": {
        "actions": [
          "create"
        ]
      },
      "type": "azurerm_virtual_machine"
    }
  ]
}

input_delete_azurerm_virtual_machine = {
  "resource_changes": [
    {
      "change": {
        "actions": [
          "delete"
        ]
      },
      "type": "azurerm_virtual_machine"
    }
  ]
}

input_update_azurerm_virtual_machine = {
  "resource_changes": [
    {
      "change": {
        "actions": [
          "update"
        ]
      },
      "type": "azurerm_virtual_machine"
    }
  ]
}

test_create_azurerm_virtual_machine {
    authz with input as input_create_azurerm_virtual_machine
}

test_delete_azurerm_virtual_machine {
    not authz with input as input_delete_azurerm_virtual_machine
}

test_update_azurerm_virtual_machine {
    authz with input as input_update_azurerm_virtual_machine
}