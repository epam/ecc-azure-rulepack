resource "azurerm_mysql_flexible_server" "this" {
  name                = "${var.prefix}-mysqlserver-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  administrator_login          = random_string.this.result
  administrator_password       = random_password.this.result
  sku_name                     = "GP_Standard_D2ds_v4"

  tags = var.tags
}
  
resource "azurerm_mysql_flexible_server_configuration" "this" {
  name                       = "sql_mode"
  resource_group_name        = azurerm_resource_group.this.name
  server_name                = azurerm_mysql_flexible_server.this.name
  value                      = "STRICT_ALL_TABLES,ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION"
  depends_on = [ azurerm_mysql_flexible_server.this ]
}