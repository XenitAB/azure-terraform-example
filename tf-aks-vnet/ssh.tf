resource "tls_private_key" "sshKey" {
  algorithm   = "RSA"
  rsa_bits = "2048"
}

resource "azurerm_key_vault_secret" "secretSshKey" {
  name         = "ssh-priv-aks-${var.environmentShort}-${var.locationShort}-${var.commonName}"
  value        = tls_private_key.sshKey.private_key_pem
  key_vault_id = data.azurerm_key_vault.coreKv.id
}