resource "kubernetes_secret" "k8sOutboundIpsSecret" {
  for_each = {
    for ns in var.k8sNamespaces :
    ns.name => ns
  }

  metadata {
    name      = "outbound-ips"
    namespace = each.key
  }

  data = {
    ip_addresses = jsonencode(
      [
        for o in data.azurerm_public_ip.aksOutboundPips :
        o.ip_address
      ]
    )
  }

  depends_on = [
    data.azurerm_public_ip.aksOutboundPips
  ]
}
