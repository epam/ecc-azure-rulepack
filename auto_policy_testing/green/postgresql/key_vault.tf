resource "azurerm_key_vault_access_policy" "postgresql" {
  key_vault_id = data.terraform_remote_state.common.outputs.key_vault_id
  tenant_id    = azurerm_postgresql_server.cmk.identity[0].tenant_id
  object_id    = azurerm_postgresql_server.cmk.identity[0].principal_id

  key_permissions    = ["Get", "UnwrapKey", "WrapKey"]
  secret_permissions = ["Get"]
}

resource "azurerm_key_vault_key" "this" {
  name         = "${module.naming.resource_prefix.keyvault-key}-${random_integer.this.result}"
  key_vault_id = data.terraform_remote_state.common.outputs.key_vault_id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  depends_on = [
    azurerm_key_vault_access_policy.postgresql
  ]
}