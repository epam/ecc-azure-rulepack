resource "azurerm_disk_encryption_set" "this" {
  name                = module.naming.resource_prefix.encryptionset
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  key_vault_key_id    = data.terraform_remote_state.common.outputs.key_id

  identity {
    type = "SystemAssigned"
  }

  tags = module.naming.default_tags
}