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

variable "k8sNamespaces" {
  description = "The namespaces that should be created in Kubernetes."
  type = list(
    object({
      name   = string
      labels = map(string)
    })
  )
}
