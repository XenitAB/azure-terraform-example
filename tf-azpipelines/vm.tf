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
  count               = var.envVmConfig.count
  name                = "nic-${local.vmBaseName}-${format("%02s", count.index + 1)}-01"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ipconfig-01"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "nicAlbBeAssociation" {
  count                   = var.envVmConfig.count
  network_interface_id    = azurerm_network_interface.nic[count.index].id
  ip_configuration_name   = "ipconfig-01"
  backend_address_pool_id = azurerm_lb_backend_address_pool.albBe.id
}

resource "azurerm_virtual_machine" "vm" {
  count               = var.envVmConfig.count
  name                = "${local.vmBaseName}-${format("%02s", count.index + 1)}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  vm_size             = var.envVmConfig.size

  network_interface_ids = [
    azurerm_network_interface.nic[count.index].id
  ]

  zones = [
    ((count.index % var.locationZoneCount) + 1)
  ]

  storage_image_reference {
    id = azurerm_image.imageFedoreCoreOs.id
  }

  storage_os_disk {
    name              = "osdisk-${local.vmBaseName}-${format("%02s", count.index + 1)}"
    caching           = var.vmConfig.storageOsDisk.caching
    create_option     = var.vmConfig.storageOsDisk.create_option
    managed_disk_type = var.vmConfig.storageOsDisk.managed_disk_type
    disk_size_gb      = var.vmConfig.storageOsDisk.disk_size_gb
  }

  os_profile {
    computer_name  = "${local.vmBaseName}-${format("%02s", count.index + 1)}"
    admin_username = var.vmConfig.username
    custom_data = jsonencode(yamldecode(templatefile(
      "${path.module}/files/ignition.yaml",
      {
        ADMIN_USER     = var.vmConfig.username,
        SSH_PUBLIC_KEY = tls_private_key.sshKey.public_key_openssh,
        HOSTNAME       = "${local.vmBaseName}-${format("%02s", count.index + 1)}",
        AZP_ACCOUNT    = jsondecode(data.azurerm_key_vault_secret.kvSecretAzurePipelinesAgent.value).azp_account,
        AZP_TOKEN      = jsondecode(data.azurerm_key_vault_secret.kvSecretAzurePipelinesAgent.value).azp_token,
        AZP_POOL       = "${var.environmentShort}${var.azureDevOpsConfiguration.azpPoolSuffix}",
        AZP_IMAGE_TAG  = var.azureDevOpsConfiguration.azpImageTag
      }
    )))
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.vmConfig.username}/.ssh/authorized_keys"
      key_data = tls_private_key.sshKey.public_key_openssh
    }
  }
}
