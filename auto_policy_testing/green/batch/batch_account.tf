resource "azurerm_batch_account" "this" {
  name                          = module.naming.resource_prefix.batch
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group
  pool_allocation_mode          = "BatchService"

  storage_account_id   = data.terraform_remote_state.common.outputs.storage_id

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }

  encryption {
    key_vault_key_id = data.terraform_remote_state.common.outputs.key_id
  }

  tags = module.naming.default_tags
}