resource "azurerm_storage_account" "this" {
  name                     = "${random_string.this.result}sagreen"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action = "Deny"
  }

  blob_properties {
    delete_retention_policy {
      days = 5
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}


resource "azurerm_key_vault_access_policy" "storage" {
  key_vault_id = data.terraform_remote_state.common.outputs.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_storage_account.this.identity.0.principal_id

  key_permissions    = ["Get", "UnwrapKey", "WrapKey"]
  secret_permissions = ["Get"]
}