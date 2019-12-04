resource "azuread_group" "aadGroupView" {
  for_each = { for ns in var.k8sNamespaces : ns.name => ns }
  name     = "aks-${var.environmentShort}-${each.value.name}-view"
}

resource "azuread_group" "aadGroupEdit" {
  for_each = { for ns in var.k8sNamespaces : ns.name => ns }
  name     = "aks-${var.environmentShort}-${each.value.name}-edit"
}

resource "azuread_group" "aadGroupClusterAdmin" {
  name = "aks-${var.environmentShort}-clusteradmin"
}

resource "azuread_group" "aadGroupClusterView" {
  name = "aks-${var.environmentShort}-clusterview"
}
