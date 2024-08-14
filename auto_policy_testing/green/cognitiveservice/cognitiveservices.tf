resource "azurerm_cognitive_account" "this" {
  name                          = module.naming.resource_prefix.cognitive
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group
  kind                          = "Face"

  public_network_access_enabled = "false"

  sku_name = "F0"

  network_acls {
    default_action = "Deny"
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.this.id
    ]
  }

  tags = module.naming.default_tags
}

resource "azurerm_cognitive_account_customer_managed_key" "this" {
  cognitive_account_id = azurerm_cognitive_account.this.id
  key_vault_key_id     = data.terraform_remote_state.common.outputs.key_id
  identity_client_id   = azurerm_user_assigned_identity.this.client_id
}