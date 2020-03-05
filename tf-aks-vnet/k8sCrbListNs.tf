resource "kubernetes_cluster_role_binding" "k8sCrbViewListNs" {
  for_each = { for ns in var.k8sNamespaces : ns.name => ns }
  metadata {
    name = "crb-${each.value.name}-view-listns"

    labels = {
      "aadGroup" = azuread_group.aadGroupView[each.key].name
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cr-list-namespaces"
  }
  subject {
    kind      = "Group"
    name      = azuread_group.aadGroupView[each.key].id
    api_group = "rbac.authorization.k8s.io"
  }

  depends_on = [
    kubernetes_namespace.k8sNs
  ]
}

resource "kubernetes_cluster_role_binding" "k8sCrbEditListNs" {
  for_each = { for ns in var.k8sNamespaces : ns.name => ns }
  metadata {
    name = "crb-${each.value.name}-edit-listns"

    labels = {
      "aadGroup" = azuread_group.aadGroupEdit[each.key].name
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cr-list-namespaces"
  }
  subject {
    kind      = "Group"
    name      = azuread_group.aadGroupEdit[each.key].id
    api_group = "rbac.authorization.k8s.io"
  }

  depends_on = [
    kubernetes_namespace.k8sNs
  ]
}
