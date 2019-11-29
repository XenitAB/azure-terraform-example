data "azuread_service_principal" "aadSp" {
  display_name = "sp-${var.environmentShort}-${var.commonName}-contributor"
}