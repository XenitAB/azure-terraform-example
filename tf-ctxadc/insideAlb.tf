resource "azurerm_lb" "insideAzureLb" {
  name                = "alb-${var.environmentShort}-${var.locationShort}-${var.commonName}-inside"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "Standard"

  dynamic "frontend_ip_configuration" {
    for_each = {
      for ip in var.azureLbConfig.insideIpAddresses : ip => ip
    }
    content {
      name                          = "fe-alb-${var.environmentShort}-${var.locationShort}-${var.commonName}-inside-${format("%02s", index(var.azureLbConfig.insideIpAddresses, frontend_ip_configuration.value) + 1)}"
      private_ip_address_allocation = "Static"
      private_ip_address            = frontend_ip_configuration.value
      subnet_id                     = data.azurerm_subnet.insideSubnet.id
    }
  }
}

resource "azurerm_lb_probe" "insideAzureLbProbe" {
  resource_group_name = data.azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_lb.insideAzureLb.id
  name                = "hp-alb-${var.environmentShort}-${var.locationShort}-${var.commonName}-inside"
  port                = 9000
  protocol            = "Tcp"
}

resource "azurerm_lb_backend_address_pool" "insideAzureLbBackendPool" {
  resource_group_name = data.azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_lb.insideAzureLb.id
  name                = "be-alb-${var.environmentShort}-${var.locationShort}-${var.commonName}-inside"
}

resource "azurerm_lb_rule" "insideAzureLbRule" {
  for_each = {
    for ip in var.azureLbConfig.insideIpAddresses : ip => ip
  }
  resource_group_name            = data.azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.insideAzureLb.id
  backend_address_pool_id        = azurerm_lb_backend_address_pool.insideAzureLbBackendPool.id
  enable_floating_ip             = true
  name                           = "lbr-alb-${var.environmentShort}-${var.locationShort}-${var.commonName}-inside-${format("%02s", index(var.azureLbConfig.insideIpAddresses, each.value) + 1)}"
  protocol                       = "All"
  frontend_port                  = 0
  backend_port                   = 0
  frontend_ip_configuration_name = "fe-alb-${var.environmentShort}-${var.locationShort}-${var.commonName}-inside-${format("%02s", index(var.azureLbConfig.insideIpAddresses, each.value) + 1)}"
  probe_id                       = azurerm_lb_probe.insideAzureLbProbe.id
}
