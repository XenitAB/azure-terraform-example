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

variable "subscriptionCommonName" {
  description = "The commonName for the subscription"
  type        = string
}

variable "coreCommonName" {
  description = "The commonName for the core infrastructure"
  type        = string
}

variable "externalDns" {
  description = "The external DNS to use with AKS"
  type        = string
}

variable "k8sNamespaces" {
  description = "The namespaces that should be created in Kubernetes."
  type = list(
    object({
      name       = string
      delegateRg = bool
      labels     = map(string)
    })
  )
}

variable "k8sSaNamespace" {
  description = "The namespaced used to store service accounts."
  type        = string
}

variable "aksConfiguration" {
  description = "The Azure Kubernetes Service (AKS) configuration"
  type = object({
    default_node_pool_kubernetes_version = string
    default_node_pool_vm_size            = string
    default_node_pool_min_count          = number
    default_node_pool_max_count          = number
  })
}
