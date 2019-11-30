resource "azuread_group" "aadGroupView" {
  for_each = { for ns in var.k8sNamespaces : ns.name => ns }
  name     = "aad-k8s-u-${var.environmentShort}-${each.value.name}-view"
}

resource "azuread_group" "aadGroupEdit" {
  for_each = { for ns in var.k8sNamespaces : ns.name => ns }
  name     = "aad-k8s-u-${var.environmentShort}-${each.value.name}-edit"
}

resource "azuread_group" "aadGroupClusterAdmin" {
  name = "aad-k8s-u-${var.environmentShort}-clusteradmin"
}

resource "azuread_group" "aadGroupClusterView" {
  name = "aad-k8s-u-${var.environmentShort}-clusterview"
}
