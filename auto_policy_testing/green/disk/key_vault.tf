data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id = data.terraform_remote_state.common.outputs.key_vault_id

  tenant_id = azurerm_disk_encryption_set.this.identity[0].tenant_id
  object_id = azurerm_disk_encryption_set.this.identity[0].principal_id

  key_permissions = [
    "Get",
    "WrapKey",
    "UnwrapKey"
  ]
}