resource "kubernetes_cluster_role_binding" "k8sCrbClusterAdmin" {
  metadata {
    name = "crb-clusteradmin"

    labels = {
      "aadGroup" = azuread_group.aadGroupClusterAdmin.name
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "Group"
    name      = azuread_group.aadGroupClusterAdmin.id
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "kubernetes_cluster_role_binding" "k8sCrbClusterView" {
  metadata {
    name = "crb-clusterview"

    labels = {
      "aadGroup" = azuread_group.aadGroupClusterView.name
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "view"
  }
  subject {
    kind      = "Group"
    name      = azuread_group.aadGroupClusterView.id
    api_group = "rbac.authorization.k8s.io"
  }
}
