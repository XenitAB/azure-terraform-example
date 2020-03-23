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
    commonName = string
    subnetName = string
  })
}

variable "vmConfig" {
  description = "Configuration of the virtual machines"
  type = object({
    username = string
    storageOsDisk = object({
      caching           = string
      create_option     = string
      managed_disk_type = string
      disk_size_gb      = number
    })
  })
}

variable "envVmConfig" {
  description = "Environment specific vm configuration"
  type = object({
    count = number
    size  = string
  })
}

variable "fedoraCoreOSConfiguration" {
  description = "Fedora CoreOS Configuration"
  type = object({
    imageVersion = string
  })
}

variable "azureDevOpsConfiguration" {
  description = "Azure DevOps Configuration"
  type = object({
    azpPoolSuffix = string
    azpImageTag   = string
  })
}
