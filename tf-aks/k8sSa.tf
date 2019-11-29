resource "kubernetes_service_account" "k8sSa" {
  for_each = { for ns in var.k8sNamespaces : ns.name => ns }

  metadata {
    name      = "sa-${each.value.name}"
    namespace = each.value.name
  }
}

data "kubernetes_secret" "k8sSaSecret" {
  for_each = { for ns in var.k8sNamespaces : ns.name => ns }

  metadata {
    name      = kubernetes_service_account.k8sSa[each.key].default_secret_name
    namespace = each.value.name
  }
}

resource "azurerm_key_vault_secret" "kvSecret" {
  for_each = { for ns in var.k8sNamespaces : ns.name => ns }

  name         = "sa-${each.value.name}"
  value        = base64encode(data.kubernetes_secret.k8sSaSecret[each.key].data)
  key_vault_id = azurerm_key_vault.kv.id
}
