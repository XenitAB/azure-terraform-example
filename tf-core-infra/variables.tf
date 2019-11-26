variable "location" {
  description = "The Azure region to create things in."
  type = string
}

variable "locationShort" {
  description = "The Azure region short name. "
  type = string
}

variable "environmentShort" {
  description = "The environment (short name) to use for the deploy"
  type = string
}

variable "commonName" {
  description = "The commonName to use for the deploy"
  type = string
}

variable "vnetConfig" {
  description = "Address spaces used by virtual network."
  type = object({
    addressSpace = list(string)
    subnets = list(object({
      name = string
      cidr = string
    }))
  })
}

variable "gatewaySubnet" {
  description = "CIDR for GatewaySubnet"
  type = string
}