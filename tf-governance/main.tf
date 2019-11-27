# Configure backend
terraform {
  backend "azurerm" {}
}

# Configure the Azure Provider
provider "azurerm" {
  version = "=1.36.0"
}

provider "azuread" {
  version = "=0.3.1"
}

# data "azuread_user" "usr" {
#   user_principal_name = "sgtest@linuslindstromxenit.onmicrosoft.com"
# }

# output "test" {
#   value = data.azuread_user.usr
# }