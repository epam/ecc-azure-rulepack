data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                = "kv${var.prefix}green${random_integer.this.result}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "premium"
  

  purge_protection_enabled = true
}

resource "azurerm_key_vault_access_policy" "mysqlmi" {
  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = azurerm_mssql_managed_instance.this.identity[0].tenant_id
  object_id    = azurerm_mssql_managed_instance.this.identity[0].principal_id
  #object_id    = azurerm_mysql_server.this.identity.0.principal_id

  key_permissions    = ["Get", "UnwrapKey", "WrapKey"]
  secret_permissions = ["Get"]
}

resource "azurerm_key_vault_access_policy" "client" {
  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions    = ["Get", "Create", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify", "GetRotationPolicy", "SetRotationPolicy"]
  secret_permissions = ["Get"]
}

resource "azurerm_key_vault_key" "this" {
  name         = "key${var.prefix}green"
  key_vault_id = azurerm_key_vault.this.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  depends_on = [
    azurerm_key_vault_access_policy.client,
    azurerm_key_vault_access_policy.mysqlmi
  ]
}