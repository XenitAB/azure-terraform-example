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
