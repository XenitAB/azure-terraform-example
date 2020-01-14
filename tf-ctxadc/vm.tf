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

resource "azurerm_marketplace_agreement" "marketplaceAgreement" {
  publisher = var.vmConfig.publisherConfig.publisher
  offer     = var.vmConfig.publisherConfig.offer
  plan      = var.vmConfig.publisherConfig.plan
}

resource "azurerm_virtual_machine" "vm" {
  count               = var.vmConfig.count
  name                = "${local.vmBaseName}-${format("%02s", count.index + 1)}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  vm_size             = var.vmConfig.size

  primary_network_interface_id = azurerm_network_interface.nicManagement[count.index].id

  network_interface_ids = [
    azurerm_network_interface.nicManagement[count.index].id,
    azurerm_network_interface.nicInside[count.index].id,
    azurerm_network_interface.nicOutside[count.index].id
  ]

  zones = [
    ((count.index % var.locationZoneCount) + 1)
  ]

  plan {
    name      = var.vmConfig.publisherConfig.plan
    publisher = var.vmConfig.publisherConfig.publisher
    product   = var.vmConfig.publisherConfig.offer
  }

  storage_image_reference {
    publisher = var.vmConfig.publisherConfig.publisher
    offer     = var.vmConfig.publisherConfig.offer
    sku       = var.vmConfig.publisherConfig.sku
    version   = var.vmConfig.publisherConfig.version
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

  depends_on = [
    azurerm_marketplace_agreement.marketplaceAgreement
  ]
}
