resource "kubernetes_namespace" "k8sNs" {
  for_each = { for ns in var.k8sNamespaces : ns.name => ns }
  metadata {
    labels = merge(
      { for k, v in each.value.labels : k => v },
      { "name" = each.value.name }
    )
    name = each.value.name
  }
}
