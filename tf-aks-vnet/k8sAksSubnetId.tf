resource "kubernetes_secret" "k8sAksSubnetId" {
  for_each = {
    for ns in var.k8sNamespaces :
    ns.name => ns
  }

  metadata {
    name      = "aks-subnet"
    namespace = each.key
  }

  data = {
    subnet_id      = data.azurerm_subnet.subnet.id
    address_prefix = data.azurerm_subnet.subnet.address_prefix
  }
}
