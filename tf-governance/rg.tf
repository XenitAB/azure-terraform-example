resource "azurerm_resource_group" "rg" {
  count     = length(var.rgConfig)
  name      = "rg-${var.environmentShort}-${var.locationShort}-${var.rgConfig[count.index].commonName}"
  location  = var.location

  tags = var.rgConfig[count.index].tags
}