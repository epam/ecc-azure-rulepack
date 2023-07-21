resource "azurerm_key_vault" "this" {
  name                        = "kv${var.prefix}green${random_integer.this.result}"
  location                    = azurerm_resource_group.this.location
  resource_group_name         = azurerm_resource_group.this.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  enabled_for_disk_encryption = true
  purge_protection_enabled    = true
  sku_name                    = "premium"
}

resource "azurerm_key_vault_key" "key" {
  name         = "${var.prefix}-key-green"
  key_vault_id = azurerm_key_vault.this.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  depends_on = [
    azurerm_key_vault_access_policy.policy2
  ]
}

resource "azurerm_key_vault_access_policy" "policy1" { #ade-policy
  key_vault_id = azurerm_key_vault.this.id

  tenant_id = azurerm_disk_encryption_set.this.identity.0.tenant_id
  object_id = azurerm_disk_encryption_set.this.identity.0.principal_id

  key_permissions = [
    "Get",
    "Decrypt",
    "Encrypt",
    "Sign",
    "UnwrapKey",
    "Verify",
    "WrapKey",
  ]
}

resource "azurerm_key_vault_access_policy" "policy2" { #user-policy
  key_vault_id = azurerm_key_vault.this.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get",
    "Create",
    "Delete"
  ]
}