data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                = "kv${var.prefix}green${random_integer.this.result}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "premium"
  enabled_for_deployment          = true
  enabled_for_disk_encryption     = true

  purge_protection_enabled = true
}

resource "azurerm_key_vault_access_policy" "client" {
  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions    = ["Create", "Delete", "Get", "List", "Import", "Encrypt", "Decrypt", "Recover", "WrapKey", "UnwrapKey", "Verify", "Sign", "Restore", "Purge", "Update", "Backup", "GetRotationPolicy", "SetRotationPolicy"]
  secret_permissions = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
}

resource "azurerm_key_vault_key" "this" {
  name         = "key${var.prefix}green"
  key_vault_id = azurerm_key_vault.this.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  depends_on = [
    azurerm_key_vault_access_policy.client
  ]
}