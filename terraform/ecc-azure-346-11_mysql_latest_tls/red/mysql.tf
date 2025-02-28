resource "azurerm_mysql_flexible_server" "this" {
  name                = "${var.prefix}-mysqlserver-red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  administrator_login          = random_string.this.result
  administrator_password       = random_password.this.result
  sku_name                     = "GP_Standard_D2ds_v4"
  }

  resource "azurerm_mysql_flexible_server_configuration" "this" {
    name                       = "tls_version"
    resource_group_name        = azurerm_resource_group.this.name
    server_name                = azurerm_mysql_flexible_server.this.name
    value                      = "TLSv1.1"
    depends_on = [ azurerm_mysql_flexible_server.this ]
  }