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

resource "azurerm_mysql_flexible_server_configuration" "this2" {
    name                       = "tls_version"
    resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
    server_name                = azurerm_mysql_flexible_server.this.name
    value                      = "TLSv1.1"
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

resource "null_resource" "enable_public_access" {
  depends_on = [azurerm_mysql_flexible_server.this]

  provisioner "local-exec" {
    command = "az mysql flexible-server update --name ${azurerm_mysql_flexible_server.this.name} --resource-group ${azurerm_mysql_flexible_server.this.resource_group_name} --public-access Enabled"
  }
}