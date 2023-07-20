resource "azurerm_mssql_server" "sql-1" {
  name                         = "${var.prefix}-sql1-green"
  resource_group_name          = azurerm_resource_group.this.name
  location                     = azurerm_resource_group.this.location
  version                      = "12.0"
  administrator_login          = random_string.this.result
  administrator_login_password = random_password.this.result
}

resource "azurerm_mssql_server" "sql-2" {
  name                         = "${var.prefix}-sql2-green"
  resource_group_name          = azurerm_resource_group.this.name
  location                     = "northeurope"
  version                      = "12.0"
  administrator_login          = random_string.this.result
  administrator_login_password = random_password.this.result
}

resource "azurerm_mssql_database" "db1" {
  name      = "${var.prefix}-db-green"
  server_id = azurerm_mssql_server.sql-1.id
}

resource "azurerm_mssql_failover_group" "this" {
  name      = "${var.prefix}failover-group"
  server_id = azurerm_mssql_server.sql-1.id
  databases = [azurerm_mssql_database.db1.id]
  partner_server {
    id = azurerm_mssql_server.sql-2.id
  }

  read_write_endpoint_failover_policy {
    mode          = "Automatic"
    grace_minutes = 60
  }

  tags = var.tags
}