# Configure backend
terraform {
  backend "azurerm" {}
}

# Configure the Azure Provider
provider "azurerm" {
  version = "=2.3.0"
  features {}
}
