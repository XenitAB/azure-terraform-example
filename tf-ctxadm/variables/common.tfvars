location          = "West Europe"
locationShort     = "we"
locationZoneCount = 3
commonName        = "ctxadm"

coreConfig = {
  commonName = "tflab"
  subnetName = "inside"
}

vmConfig = {
  count    = 1
  username = "nsadmin"
  size     = "Standard_B2s"
  publisherConfig = {
    publisher = "citrix"
    offer     = "netscaler-130-ma-service-agent"
    sku       = "netscaler-ma-service-agent"
    version   = "latest"
    plan      = "netscaler-ma-service-agent"
  }
  storageOsDisk = {
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }
}
