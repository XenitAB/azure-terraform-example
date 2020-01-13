resource "azurerm_lb" "outsideAzureLb" {
  name                = "alb-${var.environmentShort}-${var.locationShort}-${var.commonName}-outside"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "Standard"

  dynamic "frontend_ip_configuration" {
    for_each = range(var.azureLbConfig.pipCount)
    content {
      name                 = "fe-alb-${var.environmentShort}-${var.locationShort}-${var.commonName}-${format("%02s", frontend_ip_configuration.value + 1)}"
      public_ip_address_id = azurerm_public_ip.pip[frontend_ip_configuration.value].id
    }
  }
}
