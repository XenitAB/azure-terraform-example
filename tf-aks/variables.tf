variable "location" {
  description = "The Azure region to create things in."
  type = string
}

variable "locationShort" {
  description = "The Azure region short name."
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

variable "coreInfraCommonName" {
  description = "The commonName for core infra that is deployed"
  type = string
}