# Add datasource for resource group
data "azurerm_resource_group" "rg" {
  name = "rg-${var.environmentShort}-${var.locationShort}-${var.commonName}"
}

data "azurerm_resource_group" "coreInfraRg" {
  name = "rg-${var.environmentShort}-${var.locationShort}-${var.coreInfraCommonName}"
}