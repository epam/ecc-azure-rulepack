resource "azurerm_storage_account" "this" {
  name                     = "${module.naming.resource_prefix.storage}storage${random_integer.this.result}"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  account_tier             = "Standard"
  account_replication_type = "GRS"
  allow_nested_items_to_be_public = false
  infrastructure_encryption_enabled = true

  network_rules {
    default_action = "Deny"
    ip_rules                   = [data.terraform_remote_state.common.outputs.public_ip]
    virtual_network_subnet_ids = [data.terraform_remote_state.common.outputs.subnet_id]
  }

  blob_properties {
    delete_retention_policy {
      days = 5
    }
  }

  identity {
    type = "SystemAssigned"
  }

  queue_properties {

    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 10
    }

    hour_metrics {
      enabled               = true
      include_apis          = true
      version               = "1.0"
      retention_policy_days = 10
    }

    minute_metrics {
      enabled               = true
      include_apis          = true
      version               = "1.0"
      retention_policy_days = 10
    }
  }

  tags = module.naming.default_tags
}


resource "azurerm_key_vault_access_policy" "storage" {
  key_vault_id = data.terraform_remote_state.common.outputs.key_vault_id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = azurerm_storage_account.this.identity.0.principal_id

  key_permissions    = ["Get", "UnwrapKey", "WrapKey"]
  secret_permissions = ["Get"]

  depends_on = [
    azurerm_storage_account.this
  ]
}

resource "azurerm_storage_account_customer_managed_key" "this" {
  storage_account_id = azurerm_storage_account.this.id
  key_vault_id       = data.terraform_remote_state.common.outputs.key_vault_id
  key_name           = data.terraform_remote_state.common.outputs.key_name
  depends_on = [
    azurerm_storage_account.this,
    azurerm_key_vault_access_policy.storage
  ]
}