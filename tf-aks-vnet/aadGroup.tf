resource "azuread_group" "aadGroupView" {
  for_each = { for ns in var.k8sNamespaces : ns.name => ns }
  name     = "aks-${var.subscriptionCommonName}-${var.commonName}-${var.environmentShort}-${each.value.name}-view"
}

resource "azurerm_role_assignment" "groupViewAksAssignment" {
  for_each             = { for ns in var.k8sNamespaces : ns.name => ns }
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  principal_id         = azuread_group.aadGroupView[each.key].id
}

resource "azuread_group" "aadGroupEdit" {
  for_each = { for ns in var.k8sNamespaces : ns.name => ns }
  name     = "aks-${var.subscriptionCommonName}-${var.commonName}-${var.environmentShort}-${each.value.name}-edit"
}

resource "azurerm_role_assignment" "groupEditAksAssignment" {
  for_each             = { for ns in var.k8sNamespaces : ns.name => ns }
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  principal_id         = azuread_group.aadGroupEdit[each.key].id
}

resource "azuread_group" "aadGroupClusterAdmin" {
  name = "aks-${var.subscriptionCommonName}-${var.commonName}-${var.environmentShort}-clusteradmin"
}

resource "azurerm_role_assignment" "groupClusterAdminAksAssignment" {
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  principal_id         = azuread_group.aadGroupClusterAdmin.id
}

resource "azuread_group" "aadGroupClusterView" {
  name = "aks-${var.subscriptionCommonName}-${var.commonName}-${var.environmentShort}-clusterview"
}

resource "azurerm_role_assignment" "groupClusterViewAksAssignment" {
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Azure Kubernetes Service Cluster User Role"
  principal_id         = azuread_group.aadGroupClusterView.id
}
