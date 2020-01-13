variable "location" {
  description = "The Azure region to create things in."
  type        = string
}

variable "locationShort" {
  description = "The Azure region short name."
  type        = string
}

variable "locationZoneCount" {
  description = "Number of zones in Azure region."
  type        = number
}

variable "environmentShort" {
  description = "The environment (short name) to use for the deploy"
  type        = string
}

variable "commonName" {
  description = "The commonName to use for the deploy"
  type        = string
}

variable "coreConfig" {
  description = "The configuration of the core infra"
  type = object({
    commonName           = string
    insideSubnetName     = string
    outsideSubnetName    = string
    managementSubnetName = string
  })
}

variable "ipConfiguration" {
  description = "IP Configuration for the different subnets"
  type = list(object({
    management = list(string)
    inside     = list(string)
    outside    = list(string)
  }))
}

variable "azureLbConfig" {
  description = "Configuration for the Azure LB"
  type = object({
    pipCount          = number
    insideIpAddresses = list(string)
  })
}

variable "vmConfig" {
  description = "Configuration of the virtual machines"
  type = object({
    count    = number
    username = string
    size     = string
    publisherConfig = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
      plan      = string
    })
    storageOsDisk = object({
      caching           = string
      create_option     = string
      managed_disk_type = string
    })
  })
}
