resource "azurerm_resource_group" "rg" {
  for_each = { for rg in var.rgConfig : rg.commonName => rg }
  name     = "rg-${var.environmentShort}-${var.locationShort}-${each.value.commonName}"
  location = var.location
  tags     = each.value.tags
}
