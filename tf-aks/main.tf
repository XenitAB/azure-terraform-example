# Configure backend
terraform {
  backend "azurerm" {}
}

# Configure the Azure Provider
provider "azurerm" {
  version = "=1.37.0"
}

# Configure the Azure AD Provider
provider "azuread" {
  version = "=0.7.0"
}

# Configure the Kubernetes Provider
provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.aks.kube_config.0.host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.aks.kube_admin_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.aks.kube_admin_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.aks.kube_admin_config.0.cluster_ca_certificate)
}
