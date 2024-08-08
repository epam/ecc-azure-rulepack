data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id = data.terraform_remote_state.common.outputs.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_storage_account.this.identity[0].principal_id

  key_permissions = [
    "Get", "WrapKey", "UnwrapKey"
  ]

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [azurerm_storage_account.this]
}

resource "azurerm_storage_account_customer_managed_key" "this" {
  storage_account_id = azurerm_storage_account.this.id
  key_vault_id       = data.terraform_remote_state.common.outputs.key_vault_id
  key_name           = data.terraform_remote_state.common.outputs.key_name

  depends_on = [
    azurerm_storage_account.this,
    azurerm_key_vault_access_policy.this
  ]
}