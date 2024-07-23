resource "azurerm_key_vault_access_policy" "policy1" {
  key_vault_id = data.terraform_remote_state.common.outputs.key_vault_id
  tenant_id    = azurerm_mssql_server.this.identity[0].tenant_id
  object_id    = azurerm_mssql_server.this.identity[0].principal_id

  key_permissions = [
    "Get", "WrapKey", "UnwrapKey"
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_key_vault_access_policy" "policy2" {
  key_vault_id = data.terraform_remote_state.common.outputs.key_vault_id
  tenant_id    = azurerm_mssql_server.failover.identity[0].tenant_id
  object_id    = azurerm_mssql_server.failover.identity[0].principal_id

  key_permissions = [
    "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_key_vault_access_policy" "policy3" {
  key_vault_id = data.terraform_remote_state.common.outputs.key_vault_id
  tenant_id    = azurerm_mssql_managed_instance.this.identity[0].tenant_id
  object_id    = azurerm_mssql_managed_instance.this.identity[0].principal_id

  key_permissions = [
    "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"
  ]

  lifecycle {
    create_before_destroy = true
  }
}