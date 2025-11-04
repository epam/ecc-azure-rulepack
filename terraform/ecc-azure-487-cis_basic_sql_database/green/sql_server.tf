resource "azurerm_mssql_server" "this" {
  name                         = "${var.prefix}azuresqlserver-green"
  resource_group_name          = azurerm_resource_group.this.name
  location                     = azurerm_resource_group.this.location
  version                      = "12.0"
  administrator_login          = random_string.this.result
  administrator_login_password = random_password.this.result
}

resource "azurerm_mssql_database" "this" {
  name           = "${var.prefix}azuresqldb-green"
  server_id      = azurerm_mssql_server.this.id
  max_size_gb    = 4
  sku_name       = "BC_Gen5_2"
  zone_redundant = false

  tags = var.tags
}