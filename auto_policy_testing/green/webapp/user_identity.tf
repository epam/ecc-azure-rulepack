data "azurerm_client_config" "current" {}

resource "azurerm_user_assigned_identity" "this" {
  name                = module.naming.resource_prefix.useridentity
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
}

resource "azurerm_key_vault_access_policy" "user_assigned" {
  key_vault_id = data.terraform_remote_state.common.outputs.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.this.principal_id

  key_permissions    = ["Get", "UnwrapKey", "WrapKey"]
  secret_permissions = ["Get"]

  depends_on = [
    azurerm_storage_account.this
  ]
}