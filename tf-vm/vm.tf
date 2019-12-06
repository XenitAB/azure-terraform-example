locals {
  vmBaseName = "vm-${var.environmentShort}-${var.locationShort}-${var.commonName}"
}

resource "random_password" "vmPassword" {
  length  = 16
  special = true

  keepers = {
    vmPassword = var.commonName
  }
}

resource "azurerm_key_vault_secret" "vmPassword" {
  name         = local.vmBaseName
  value        = random_password.vmPassword.result
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_network_interface" "nic" {
  count               = var.vmConfig.count
  name                = "nic-${local.vmBaseName}-${format("%02s", count.index + 1)}-01"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig-01"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  count               = var.vmConfig.count
  name                = "${local.vmBaseName}-${format("%02s", count.index + 1)}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  vm_size             = var.vmConfig.size

  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id
  ]

  zones = [
    ((count.index % var.locationZoneCount) + 1)
  ]

  storage_image_reference {
    publisher = var.vmConfig.storageImageReference.publisher
    offer     = var.vmConfig.storageImageReference.offer
    sku       = var.vmConfig.storageImageReference.sku
    version   = var.vmConfig.storageImageReference.version
  }

  storage_os_disk {
    name              = "osdisk-${local.vmBaseName}-${format("%02s", count.index + 1)}"
    caching           = var.vmConfig.storageOsDisk.caching
    create_option     = var.vmConfig.storageOsDisk.create_option
    managed_disk_type = var.vmConfig.storageOsDisk.managed_disk_type
  }

  os_profile {
    computer_name  = "${local.vmBaseName}-${format("%02s", count.index + 1)}"
    admin_username = var.vmConfig.username
    admin_password = random_password.vmPassword.result
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
