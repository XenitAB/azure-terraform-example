variable "location" {
  description = "The Azure region to create things in."
  default = "West Europe"
}

variable "locationShort" {
  description = "The Azure region short name."
  default = "we"
}

variable "environmentShort" {
  description = "The environment (short name) to use for the deploy"
}

variable "vnetConfig" {
  description = "Address spaces used."
  type = map

  default = {
    dev = {
      addressSpace = [ "10.100.0.0/16" ]
    }
    qa = {
      addressSpace = [ "10.101.0.0/16" ]
    }
    prod = {
      addressSpace = [ "10.102.0.0/16" ]
    }
  }
}