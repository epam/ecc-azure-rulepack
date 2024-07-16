data "azurerm_client_config" "current" {}

resource "azurerm_mssql_server" "this" {
  name                          = module.naming.resource_prefix.sql-server
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group
  version                       = "12.0"
  administrator_login           = random_string.this.result
  administrator_login_password  = random_password.this.result
  public_network_access_enabled = false
  minimum_tls_version           = "1.2"
  

  azuread_administrator {
    login_username              = "sqladmin-sql-server-green"
    object_id                   = data.azurerm_client_config.current.object_id
    azuread_authentication_only = true
  }

  identity {
    type = "SystemAssigned"
  }

  tags = module.naming.default_tags

  lifecycle {
    ignore_changes = [transparent_data_encryption_key_vault_key_id]
  }
}

resource "azurerm_mssql_server" "failover" {
  name                         = "${module.naming.resource_prefix.sql-server}-failover"
  location                     = data.terraform_remote_state.common.outputs.location
  resource_group_name          = data.terraform_remote_state.common.outputs.resource_group
  version                      = "12.0"
  administrator_login          = random_string.this.result
  administrator_login_password = random_password.this.result
  public_network_access_enabled = false
  minimum_tls_version           = "1.2"

  azuread_administrator {
    login_username              = "sqladmin-sql-server-green"
    object_id                   = data.azurerm_client_config.current.object_id
    azuread_authentication_only = true
  }

  identity {
    type = "SystemAssigned"
  }
  
  tags                         = module.naming.default_tags

  lifecycle {
    ignore_changes = [transparent_data_encryption_key_vault_key_id]
  }
}

resource "azurerm_mssql_server_extended_auditing_policy" "this" {
  server_id                               = azurerm_mssql_server.this.id
  storage_endpoint                        = data.terraform_remote_state.common.outputs.storage_blob_endpoint
  storage_account_access_key              = data.terraform_remote_state.common.outputs.storage_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 90
}

resource "azurerm_mssql_server_security_alert_policy" "this" {
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  server_name                = azurerm_mssql_server.this.name
  state                      = "Enabled"
}

resource "azurerm_mssql_server_transparent_data_encryption" "this" {
  server_id        = azurerm_mssql_server.this.id
  key_vault_key_id = data.terraform_remote_state.common.outputs.key_id

  depends_on = [
    azurerm_key_vault_access_policy.policy1,
    azurerm_mssql_server.this
  ]
}

resource "azurerm_mssql_server_transparent_data_encryption" "failover" {
  server_id        = azurerm_mssql_server.failover.id
  key_vault_key_id = data.terraform_remote_state.common.outputs.key_id

  depends_on = [
    azurerm_key_vault_access_policy.policy2,
    azurerm_mssql_server.failover
  ]
}

resource "azurerm_mssql_failover_group" "this" {
  name      = module.naming.resource_prefix.failovergroup
  server_id = azurerm_mssql_server.this.id
  databases = [azurerm_mssql_database.this.id]
  partner_server {
    id = azurerm_mssql_server.failover.id
  }

  read_write_endpoint_failover_policy {
    mode          = "Automatic"
    grace_minutes = 60
  }

  tags = module.naming.default_tags

  depends_on = [
    azurerm_mssql_server_transparent_data_encryption.this,
    azurerm_mssql_server_transparent_data_encryption.failover
  ]
}



