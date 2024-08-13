data "azurerm_client_config" "current" {}

resource "azurerm_user_assigned_identity" "this" {
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  name = module.naming.resource_prefix.useridentity
}

resource "azurerm_key_vault_access_policy" "user_identity" {
  key_vault_id = data.terraform_remote_state.common.outputs.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_user_assigned_identity.this.principal_id

  key_permissions = [
    "Get",
    "WrapKey",
    "UnwrapKey"
  ]

}

