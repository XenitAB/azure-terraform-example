variable "location" {
  description = "The Azure region to create things in."
  type        = string
}

variable "locationShort" {
  description = "The Azure region short name."
  type        = string
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
    commonName = string
    subnetName = string
  })
}

variable "vmConfig" {
  description = "Configuration of the virtual machines"
  type = object({
    count    = number
    username = string
    size     = string
    storageImageReference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    storageOsDisk = object({
      caching           = string
      create_option     = string
      managed_disk_type = string
    })
  })
}
