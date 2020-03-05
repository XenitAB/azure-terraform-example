resource "azurerm_key_vault" "delegateKv" {
  for_each = {
    for rg in var.rgConfig :
    rg.commonName => rg
    if rg.delegateKv == true
  }

  name                = "kv-${var.environmentShort}-${var.locationShort}-${each.key}"
  location            = azurerm_resource_group.rg[each.key].location
  resource_group_name = azurerm_resource_group.rg[each.key].name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
}

resource "azurerm_key_vault_access_policy" "delegateKvApCurSpn" {
  for_each = {
    for rg in var.rgConfig :
    rg.commonName => rg
    if rg.delegateKv == true
  }

  key_vault_id       = azurerm_key_vault.delegateKv[each.key].id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = data.azurerm_client_config.current.object_id
  key_permissions    = var.kvDefaultPermissions.key_permissions
  secret_permissions = var.kvDefaultPermissions.secret_permissions
}

resource "azurerm_key_vault_access_policy" "delegateKvApRgAadGroup" {
  for_each = {
    for rg in var.rgConfig :
    rg.commonName => rg
    if rg.delegateKv == true
  }

  key_vault_id       = azurerm_key_vault.delegateKv[each.key].id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = azuread_group.aadGroupContributor[each.key].id
  key_permissions    = var.kvDefaultPermissions.key_permissions
  secret_permissions = var.kvDefaultPermissions.secret_permissions
}

resource "azurerm_key_vault_access_policy" "delegateKvApRgSp" {
  for_each = {
    for rg in var.rgConfig :
    rg.commonName => rg
    if rg.delegateKv == true
  }

  key_vault_id       = azurerm_key_vault.delegateKv[each.key].id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = azuread_service_principal.aadSp[each.key].object_id
  key_permissions    = var.kvDefaultPermissions.key_permissions
  secret_permissions = var.kvDefaultPermissions.secret_permissions
}

resource "azurerm_key_vault_access_policy" "delegateKvApKvreaderSp" {
  for_each = {
    for rg in var.rgConfig :
    rg.commonName => rg
    if rg.delegateKv == true
  }

  key_vault_id       = azurerm_key_vault.delegateKv[each.key].id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = azuread_service_principal.delegateKvAadSp[each.key].object_id
  key_permissions    = var.kvDefaultPermissions.key_permissions
  secret_permissions = var.kvDefaultPermissions.secret_permissions
}
