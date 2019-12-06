location          = "West Europe"
locationShort     = "we"
locationZoneCount = 3
commonName        = "vm"

coreConfig = {
  commonName = "tflab"
  subnetName = "inside"
}

vmConfig = {
  count    = 2
  username = "localadmin"
  size     = "Standard_DS1_v2"
  storageImageReference = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storageOsDisk = {
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
}
