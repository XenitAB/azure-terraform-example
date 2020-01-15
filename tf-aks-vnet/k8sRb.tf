resource "kubernetes_role_binding" "k8sRbView" {
  for_each = { for ns in var.k8sNamespaces : ns.name => ns }
  metadata {
    name      = "rb-${each.value.name}-view"
    namespace = each.value.name

    labels = {
      "aadGroup" = azuread_group.aadGroupView[each.key].name
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "view"
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

resource "kubernetes_role_binding" "k8sRbEdit" {
  for_each = { for ns in var.k8sNamespaces : ns.name => ns }
  metadata {
    name      = "rb-${each.value.name}-edit"
    namespace = each.value.name

    labels = {
      "aadGroup" = azuread_group.aadGroupEdit[each.key].name
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "edit"
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

resource "kubernetes_role_binding" "k8sRbCitrix" {
  for_each = { for ns in var.k8sNamespaces : ns.name => ns }
  metadata {
    name      = "rb-${each.value.name}-citrix"
    namespace = each.value.name

    labels = {
      "aadGroup" = azuread_group.aadGroupEdit[each.key].name
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cr-citrix"
  }
  subject {
    kind      = "Group"
    name      = azuread_group.aadGroupEdit[each.key].id
    api_group = "rbac.authorization.k8s.io"
  }

  depends_on = [
    kubernetes_namespace.k8sNs,
    kubernetes_cluster_role.crCitrix
  ]
}

resource "kubernetes_role_binding" "k8sRbSaEdit" {
  for_each = { for ns in var.k8sNamespaces : ns.name => ns }
  metadata {
    name      = "rb-sa-${each.value.name}-edit"
    namespace = each.value.name

  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "edit"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.k8sSa[each.key].metadata[0].name
    namespace = var.k8sSaNamespace
  }

  depends_on = [
    kubernetes_namespace.k8sSaNs,
    kubernetes_service_account.k8sSa
  ]
}

resource "kubernetes_role_binding" "k8sRbSaCitrix" {
  for_each = { for ns in var.k8sNamespaces : ns.name => ns }
  metadata {
    name      = "rb-sa-${each.value.name}-citrix"
    namespace = each.value.name

  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cr-citrix"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.k8sSa[each.key].metadata[0].name
    namespace = var.k8sSaNamespace
  }

  depends_on = [
    kubernetes_namespace.k8sSaNs,
    kubernetes_service_account.k8sSa,
    kubernetes_cluster_role.crCitrix
  ]
}
