variable "location" {
  description = "The Azure region to create things in."
  default = "West Europe"
}

variable "locationShort" {
  description = "The Azure region short name."
  default = "we"
}

variable "environment" {
  description = "The environment to use for the deploy"
  default = "useracceptancetest"
}

variable "environmentShort" {
  description = "The environment (short name) to use for the deploy"
  default = "uat"
}

variable "vnetConfig" {
  description = "Address spaces used."
  type = map

  default = {
    uat = {
      addressSpace = [ "10.100.0.0/16" ]
    }
    prod = {
      addressSpace = [ "10.101.0.0/16" ]
    }
  }
}