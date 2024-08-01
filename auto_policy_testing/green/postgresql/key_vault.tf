#data "azurerm_client_config" "current" {}
#
#resource "azurerm_key_vault" "this" {
#  name                       = "${module.naming.resource_prefix.keyvault}${random_integer.this.result}"
#  location                   = data.terraform_remote_state.common.outputs.location
#  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
#  tenant_id                  = data.azurerm_client_config.current.tenant_id
#  sku_name                   = "premium"
#
#  purge_protection_enabled = true
#}

#resource "azurerm_key_vault_access_policy" "server" {
#  key_vault_id = azurerm_key_vault.this.id
#  tenant_id    = azurerm_postgresql_server.cmk.identity[0].tenant_id
#  object_id    = azurerm_postgresql_server.cmk.identity[0].principal_id
#
#  key_permissions    = ["Get", "UnwrapKey", "WrapKey"]
#  secret_permissions = ["Get"]
#}

#resource "azurerm_key_vault_access_policy" "client" {
#  key_vault_id = azurerm_key_vault.this.id
#  tenant_id    = data.azurerm_client_config.current.tenant_id
#  object_id    = data.azurerm_client_config.current.object_id
#
#  key_permissions    = ["Get", "Create", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify", "GetRotationPolicy", "SetRotationPolicy"]
#  secret_permissions = ["Get"]
#}

#resource "azurerm_key_vault_key" "this" {
#  name         = "${module.naming.resource_prefix.keyvault-key}-${random_integer.this.result}"
#  key_vault_id = azurerm_key_vault.this.id
#  key_type     = "RSA"
#  key_size     = 2048
#  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
#
#  depends_on = [
#    azurerm_key_vault_access_policy.server,
#    azurerm_key_vault_access_policy.client
#  ]
#}