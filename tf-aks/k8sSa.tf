resource "kubernetes_service_account" "k8sSa" {
  for_each = { for ns in var.k8sNamespaces : ns.name => ns }

  metadata {
    name      = "sa-${each.value.name}"
    namespace = var.k8sSaNamespace
  }
}

data "kubernetes_secret" "k8sSaSecret" {
  for_each = { for ns in var.k8sNamespaces : ns.name => ns }

  metadata {
    name      = kubernetes_service_account.k8sSa[each.key].default_secret_name
    namespace = var.k8sSaNamespace
  }
}
