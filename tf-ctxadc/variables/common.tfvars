location          = "West Europe"
locationShort     = "we"
locationZoneCount = 3
commonName        = "ctxadc"

coreConfig = {
  commonName           = "tflab"
  insideSubnetName     = "inside"
  outsideSubnetName    = "outside"
  managementSubnetName = "management"
}

vmConfig = {
  count    = 2
  username = "adcadmin"
  size     = "Standard_DS3_v2"
  publisherConfig = {
    publisher = "citrix"
    offer     = "netscalervpx-130"
    sku       = "netscalerbyol"
    version   = "latest"
    plan      = "netscalerbyol"
  }
  storageOsDisk = {
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
  }
}
