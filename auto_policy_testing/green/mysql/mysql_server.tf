resource "azurerm_mysql_flexible_server" "this" {
  name                          = module.naming.resource_prefix.mysql-flexibleserver
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group

  administrator_login          = random_string.this.result
  administrator_password       = random_password.this.result
  sku_name                     = "GP_Standard_D2ds_v4"

  delegated_subnet_id          = data.terraform_remote_state.common.outputs.subnet_id
  private_dns_zone_id          = data.terraform_remote_state.common.outputs.dns_id

  geo_redundant_backup_enabled = false

  identity {
    type = "UserAssigned"
    identity_ids = [ data.terraform_remote_state.common.outputs.user_assigned_id ]
  }
  
  customer_managed_key {
    key_vault_key_id = "${data.terraform_remote_state.common.outputs.key_id}"
    primary_user_assigned_identity_id = data.terraform_remote_state.common.outputs.user_assigned_id
  }
  
  tags = module.naming.default_tags
}

resource "azurerm_mysql_flexible_server_configuration" "this1" {
  name                       = "local_infile"
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  server_name                = azurerm_mysql_flexible_server.this.name
  value                      = "OFF"
  depends_on = [ azurerm_mysql_flexible_server.this ]
}

resource "azurerm_mysql_flexible_server_configuration" "this2" {
  name                       = "max_user_connections"
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  server_name                = azurerm_mysql_flexible_server.this.name
  value                      = "50"
  depends_on = [ azurerm_mysql_flexible_server.this ]
}

resource "azurerm_mysql_flexible_server_configuration" "this3" {
  name                       = "slow_query_log"
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  server_name                = azurerm_mysql_flexible_server.this.name
  value                      = "ON"
  depends_on = [ azurerm_mysql_flexible_server.this ]
}

resource "azurerm_mysql_flexible_server_configuration" "this4" {
  name                       = "sql_mode"
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  server_name                = azurerm_mysql_flexible_server.this.name
  value                      = "STRICT_ALL_TABLES,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"
  depends_on = [ azurerm_mysql_flexible_server.this ]
}

resource "azurerm_mysql_flexible_server_configuration" "this5" {
  name                       = "audit_log_enabled"
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  server_name                = azurerm_mysql_flexible_server.this.name
  value                      = "ON"
  depends_on = [ azurerm_mysql_flexible_server.this ]
}

resource "azurerm_mysql_flexible_server_configuration" "this6" {
  name                       = "audit_log_events"
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  server_name                = azurerm_mysql_flexible_server.this.name
  value                      = "CONNECTION"
  depends_on = [ azurerm_mysql_flexible_server.this ]
}