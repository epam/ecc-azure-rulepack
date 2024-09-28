data "azurerm_client_config" "current" {}

resource "azurerm_mssql_server" "this" {
  name                          = module.naming.resource_prefix.sql-server
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group
  version                       = "12.0"
  administrator_login           = "Administratorsql"
  administrator_login_password  = random_password.this.result
  public_network_access_enabled = true
  minimum_tls_version           = "1.1"
  
  tags = module.naming.default_tags
}

resource "azurerm_mssql_firewall_rule" "this" {
  name             = "sql-server-fwrule-red"
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.1"
}

resource "azurerm_mssql_server_security_alert_policy" "this" {
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  server_name                = azurerm_mssql_server.this.name
  state                      = "Disabled"
}

resource "azurerm_mssql_server" "audit" {
  name                          = "${module.naming.resource_prefix.sql-server}-audit"
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group
  version                       = "12.0"
  administrator_login           = "administratorsql"
  administrator_login_password  = random_password.this.result
  public_network_access_enabled = true
  
  tags = module.naming.default_tags

  provisioner "local-exec" {
    command = "az sql server ad-admin create -u 'Administrator' -i $adminId -g $resourceGroup -s $resourceName"

    environment = {
      resourceGroup = "${data.terraform_remote_state.common.outputs.resource_group}",
      resourceName  = "autotest-sql-sql-server-red-audit",
      adminId       = "${data.azurerm_client_config.current.object_id}"
    }
  }
}

resource "azurerm_mssql_server_extended_auditing_policy" "this" {
  server_id                               = azurerm_mssql_server.audit.id
  storage_endpoint                        = data.terraform_remote_state.common.outputs.storage_endpoint
  storage_account_access_key              = data.terraform_remote_state.common.outputs.storage_key
  storage_account_access_key_is_secondary = false
  retention_in_days                       = 7
}