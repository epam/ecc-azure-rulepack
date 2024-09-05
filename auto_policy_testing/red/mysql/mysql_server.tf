resource "azurerm_mysql_flexible_server" "this" {
  name                          = module.naming.resource_prefix.mysql-flexibleserver
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group

  administrator_login          = random_string.this.result
  administrator_password       = random_password.this.result
  sku_name                     = "GP_Standard_D2ds_v4"

  geo_redundant_backup_enabled = false

  tags = module.naming.default_tags
}

resource "azurerm_mysql_flexible_server_configuration" "this1" {
    name                       = "require_secure_transport"
    resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
    server_name                = azurerm_mysql_flexible_server.this.name
    value                      = "OFF"
    depends_on = [ azurerm_mysql_flexible_server.this ]
}

resource "azurerm_mysql_flexible_server_configuration" "this3" {
  name                       = "local_infile"
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  server_name                = azurerm_mysql_flexible_server.this.name
  value                      = "ON"
  depends_on = [ azurerm_mysql_flexible_server.this ]
}

resource "azurerm_mysql_flexible_server_configuration" "this4" {
  name                       = "audit_log_enabled"
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  server_name                = azurerm_mysql_flexible_server.this.name
  value                      = "OFF"
  depends_on = [ azurerm_mysql_flexible_server.this ]
}

resource "azurerm_mysql_flexible_server_configuration" "this5" {
  name                       = "audit_log_events"
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  server_name                = azurerm_mysql_flexible_server.this.name
  value                      = "GENERAL"
  depends_on = [ azurerm_mysql_flexible_server.this ]
}

resource "azurerm_mysql_flexible_server_firewall_rule" "this6" {
  name                = "AllowAll"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  server_name         = azurerm_mysql_flexible_server.this.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
