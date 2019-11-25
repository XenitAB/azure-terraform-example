# Configure backend
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-dev-we-tfstate"
    storage_account_name = "strgdevwetfstate"
    container_name       = "tfstate"
  }
}

# Configure the Azure Provider
provider "azurerm" {
  version = "=1.36.0"
}