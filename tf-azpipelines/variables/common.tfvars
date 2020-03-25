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
  azpImage      = "quay.io/xenitab/azp-agent"
  azpImageTag   = "stable"
}
