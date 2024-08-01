resource "azurerm_key_vault_access_policy" "postgresql" {
  key_vault_id = data.terraform_remote_state.common.outputs.key_vault_id
  tenant_id    = azurerm_postgresql_server.cmk.identity[0].tenant_id
  object_id    = azurerm_postgresql_server.cmk.identity[0].principal_id

  key_permissions    = ["Get", "UnwrapKey", "WrapKey"]
  secret_permissions = ["Get"]
}