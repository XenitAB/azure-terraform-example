resource "azurerm_public_ip" "pip" {
  count               = var.azureLbConfig.pipCount
  name                = "pip-alb-${var.environmentShort}-${var.locationShort}-${var.commonName}-${format("%02s", count.index + 1)}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}
