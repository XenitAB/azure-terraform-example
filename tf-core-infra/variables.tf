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

variable "groupCommonName" {
  description = "The groupCommonName to use for the deploy"
  type        = string
}

variable "commonName" {
  description = "The commonName to use for the deploy"
  type        = string
}

variable "gatewaySubnet" {
  description = "IP Address subnet space for GatewaySubnet"
  type        = string
}

variable "vnetConfig" {
  description = "Address spaces used by virtual network."
  type = object({
    addressSpace = list(string)
    subnets = list(object({
      name              = string
      cidr              = string
      service_endpoints = list(string)
      aksSubnet         = bool
    }))
  })
}

variable "hubVnetId" {
  description = "The virtual network id of hub network"
  type        = string
}

variable "vpnConfiguration" {
  description = "VPN Configuration"
  type = list(object({
    name            = string
    remoteGatewayIp = string
    remoteSubnets   = list(string)
  }))
}
