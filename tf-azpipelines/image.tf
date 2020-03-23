resource "azurerm_storage_account" "storageAccountImages" {
  name                     = "strg${var.environmentShort}${var.locationShort}${var.commonName}img"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  account_kind             = "StorageV2"
}

resource "azurerm_storage_container" "storageAccountContainer" {
  name                  = "images"
  storage_account_name  = azurerm_storage_account.storageAccountImages.name
  container_access_type = "private"
}

resource "null_resource" "downloadFedoraCoreOsImage" {
  provisioner "local-exec" {
    command = "wget -qO- https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/${var.fedoraCoreOSConfiguration.imageVersion}/x86_64/fedora-coreos-${var.fedoraCoreOSConfiguration.imageVersion}-azure.x86_64.vhd.xz | gunzip -c > /tmp/fedora-coreos-${var.fedoraCoreOSConfiguration.imageVersion}-azure.x86_64.vhd"
  }

  triggers = {
    version = sha1(var.fedoraCoreOSConfiguration.imageVersion)
  }
}

resource "null_resource" "uploadFedoraCoreOsImage" {
  provisioner "local-exec" {
    command = "az storage blob upload --no-progress --file /tmp/fedora-coreos-${var.fedoraCoreOSConfiguration.imageVersion}-azure.x86_64.vhd --account-name ${azurerm_storage_account.storageAccountImages.name} --container-name ${azurerm_storage_container.storageAccountContainer.name} --name fedora-coreos-${var.fedoraCoreOSConfiguration.imageVersion}-azure.x86_64.vhd"
  }

  triggers = {
    version = sha1(var.fedoraCoreOSConfiguration.imageVersion)
  }

  depends_on = [
    null_resource.downloadFedoraCoreOsImage
  ]
}

resource "azurerm_image" "imageFedoreCoreOs" {
  name                = "image-${var.environmentShort}-${var.locationShort}-${var.commonName}-fcos"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  os_disk {
    os_type  = "Linux"
    os_state = "Generalized"
    blob_uri = "https://${azurerm_storage_account.storageAccountImages.primary_blob_host}/${azurerm_storage_container.storageAccountContainer.name}/fedora-coreos-${var.fedoraCoreOSConfiguration.imageVersion}-azure.x86_64.vhd"
  }

  depends_on = [
    null_resource.uploadFedoraCoreOsImage
  ]
}
