resource "kubernetes_cluster_role" "crCitrix" {
  metadata {
    name = "cr-citrix"
  }

  rule {
    api_groups = ["citrix.com"]
    resources  = ["*"]
    verbs      = ["*"]
  }
}

resource "kubernetes_cluster_role" "crListNamespaces" {
  metadata {
    name = "cr-list-namespaces"
  }

  rule {
    api_groups = [""]
    resources  = ["namespaces"]
    verbs      = ["get", "list", "watch"]
  }
}
