resource "azuread_application" "aksSp" {
  name = "sp-${var.environmentShort}-${var.commonName}-akssp"
}

resource "azuread_service_principal" "aksSp" {
  application_id = azuread_application.aksSp.application_id
}

resource "azuread_service_principal_password" "aksSp" {
  service_principal_id = azuread_service_principal.aksSp.id
  value                = random_string.aksSp.result
  end_date             = timeadd(timestamp(), "87600h") # 10 years
  lifecycle {
    ignore_changes = [
      end_date
    ]
  }
}

resource "random_string" "aksSp" {
  length  = 16
  special = true

  keepers = {
    service_principal = azuread_service_principal.aksSp.id
  }
}
