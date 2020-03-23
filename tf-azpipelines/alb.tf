resource "azurerm_public_ip" "pip" {
  name                = "pip-alb-${var.environmentShort}-${var.locationShort}-${var.commonName}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "alb" {
  name                = "alb-${var.environmentShort}-${var.locationShort}-${var.commonName}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "fe-${var.environmentShort}-${var.locationShort}-${var.commonName}"
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "albBe" {
  resource_group_name = data.azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_lb.alb.id
  name                = "be-${var.environmentShort}-${var.locationShort}-${var.commonName}"
}

resource "azurerm_lb_outbound_rule" "albOutboundRule" {
  resource_group_name     = data.azurerm_resource_group.rg.name
  loadbalancer_id         = azurerm_lb.alb.id
  name                    = "or-${var.environmentShort}-${var.locationShort}-${var.commonName}"
  protocol                = "All"
  backend_address_pool_id = azurerm_lb_backend_address_pool.albBe.id

  frontend_ip_configuration {
    name = "fe-${var.environmentShort}-${var.locationShort}-${var.commonName}"
  }
}
