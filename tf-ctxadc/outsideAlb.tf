resource "azurerm_lb" "outsideAzureLb" {
  name                = "alb-${var.environmentShort}-${var.locationShort}-${var.commonName}-outside"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "Standard"

  dynamic "frontend_ip_configuration" {
    for_each = range(var.azureLbConfig.pipCount)
    content {
      name                 = "fe-alb-${var.environmentShort}-${var.locationShort}-${var.commonName}-outside-${format("%02s", frontend_ip_configuration.value + 1)}"
      public_ip_address_id = azurerm_public_ip.pip[frontend_ip_configuration.value].id
    }
  }
}

resource "azurerm_lb_probe" "outsideAzureLbProbe" {
  resource_group_name = data.azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_lb.outsideAzureLb.id
  name                = "hp-alb-${var.environmentShort}-${var.locationShort}-${var.commonName}-outside"
  port                = 9000
  protocol            = "Tcp"
}

resource "azurerm_lb_backend_address_pool" "outsideAzureLbBackendPool" {
  resource_group_name = data.azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_lb.outsideAzureLb.id
  name                = "be-alb-${var.environmentShort}-${var.locationShort}-${var.commonName}-outside"
}

resource "azurerm_lb_rule" "outsideAzureLbRule80" {
  count                          = var.azureLbConfig.pipCount
  resource_group_name            = data.azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.outsideAzureLb.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.outsideAzureLbBackendPool.id
  enable_floating_ip             = true
  name                           = "lbr-alb-${var.environmentShort}-${var.locationShort}-${var.commonName}-outside-${format("%02s", count.index + 1)}-80"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "fe-alb-${var.environmentShort}-${var.locationShort}-${var.commonName}-outside-${format("%02s", count.index + 1)}"
  probe_id                       = azurerm_lb_probe.outsideAzureLbProbe.id
}

resource "azurerm_lb_rule" "outsideAzureLbRule443" {
  count                          = var.azureLbConfig.pipCount
  resource_group_name            = data.azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.outsideAzureLb.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.outsideAzureLbBackendPool.id
  enable_floating_ip             = true
  name                           = "lbr-alb-${var.environmentShort}-${var.locationShort}-${var.commonName}-outside-${format("%02s", count.index + 1)}-443"
  protocol                       = "Tcp"
  frontend_port                  = 443
  backend_port                   = 443
  frontend_ip_configuration_name = "fe-alb-${var.environmentShort}-${var.locationShort}-${var.commonName}-outside-${format("%02s", count.index + 1)}"
  probe_id                       = azurerm_lb_probe.outsideAzureLbProbe.id
}
