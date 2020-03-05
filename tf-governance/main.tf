# Configure backend
terraform {
  backend "azurerm" {}
}

# Configure the Azure Provider
provider "azurerm" {
  version = "=2.0.0"
  features {}
}

provider "azuread" {
  version = "=0.7.0"
}

data "azurerm_subscription" "current" {}
