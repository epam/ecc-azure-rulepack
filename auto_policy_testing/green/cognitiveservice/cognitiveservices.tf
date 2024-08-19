resource "azurerm_cognitive_account" "this" {
  name                          = module.naming.resource_prefix.cognitive
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group
  kind                          = "Face"

  public_network_access_enabled = "false"

  sku_name = "P2"

  network_acls {
    default_action = "Deny"
  }

  custom_subdomain_name = "${random_integer.this.result}autotestcigreen"

  customer_managed_key {
    key_vault_key_id     = data.terraform_remote_state.common.outputs.key_id
    identity_client_id   = azurerm_user_assigned_identity.this.client_id
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.this.id
    ]
  }

  tags = module.naming.default_tags
}