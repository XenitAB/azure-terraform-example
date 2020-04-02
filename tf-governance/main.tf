# Configure backend
terraform {
  backend "azurerm" {}
}

# Configure the Azure Provider
provider "azurerm" {
  version = "=2.3.0"
  features {}
}

provider "azuread" {
  version = "=0.7.0"
}

data "azurerm_subscription" "current" {}
data "azurerm_client_config" "current" {}
