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
  description = "The commonName to use in names"
  type        = string
}

variable "coreCommonName" {
  description = "The commonName for the core infra"
  type        = string
}

variable "rgConfig" {
  description = "Resource group configuration"
  type = list(
    object({
      commonName  = string
      delegateAks = bool
      tags        = map(string)
    })
  )
}
