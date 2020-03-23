location          = "West Europe"
locationShort     = "we"
locationZoneCount = 3
commonName        = "azpipelines"

coreConfig = {
  commonName = "tflab"
  subnetName = "servers"
}

vmConfig = {
  username = "core"
  storageOsDisk = {
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = 256
  }
}

fedoraCoreOSConfiguration = {
  imageVersion = "31.20200223.3.0"
}

azureDevOpsConfiguration = {
  azpPoolSuffix = "-ubuntu"
  azpImageTag   = "ubuntu-16.04-docker-18.06.1-ce-standard"
}
