resource "azurerm_key_vault" "this" {
  name                       = "kv${var.prefix}green${random_integer.this.result}"
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = true
  tags                       = var.tags
}

resource "azurerm_key_vault_access_policy" "policy1" {
  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get", "Create", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify", "GetRotationPolicy", "SetRotationPolicy"
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_key_vault_access_policy" "policy2" {
  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = azurerm_mssql_server.sql_server.identity[0].tenant_id
  object_id    = azurerm_mssql_server.sql_server.identity[0].principal_id

  key_permissions = [
    "Get", "WrapKey", "UnwrapKey"
  ]

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [azurerm_key_vault_access_policy.policy1]
}

resource "azurerm_key_vault_key" "key" {
  name         = "key${var.prefix}"
  key_vault_id = azurerm_key_vault.this.id
  key_type     = "RSA"
  key_size     = 3072

  key_opts = [
    "unwrapKey", "wrapKey"
  ]

  depends_on = [azurerm_key_vault_access_policy.policy2]
}