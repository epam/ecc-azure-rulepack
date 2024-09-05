resource "azurerm_container_registry" "this" {
  name                          = module.naming.resource_prefix.containerregistry
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group
  sku                           = "Premium"
  admin_enabled                 = false
  anonymous_pull_enabled        = false

  encryption {
    key_vault_key_id   = data.terraform_remote_state.common.outputs.key_id
    identity_client_id = azurerm_user_assigned_identity.this.client_id
  }

  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.this.id
    ]
  }

  network_rule_set {
    default_action = "Deny"
  }

  tags = module.naming.default_tags
}

