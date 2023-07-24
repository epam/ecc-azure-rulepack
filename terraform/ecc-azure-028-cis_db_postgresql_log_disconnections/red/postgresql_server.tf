resource "azurerm_postgresql_server" "this" {
  name                = "${var.prefix}-postgresqlserver-red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  administrator_login          = random_string.this.result
  administrator_login_password = random_password.this.result

  sku_name = "B_Gen5_2"

  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true

  version                 = "9.5"
  ssl_enforcement_enabled = true
}

#resource "azurerm_postgresql_configuration" "log_checkpoints" {
#  name                = "log_checkpoints"
#  resource_group_name = azurerm_resource_group.this.name
#  server_name         = azurerm_postgresql_server.this.name
#  value               = "off"
#}
#
#resource "azurerm_postgresql_configuration" "log_connections" {
#  name                = "log_connections"
#  resource_group_name = azurerm_resource_group.this.name
#  server_name         = azurerm_postgresql_server.this.name
#  value               = "off"
#}

resource "azurerm_postgresql_configuration" "log_disconnections" {
  name                = "log_disconnections"
  resource_group_name = azurerm_resource_group.this.name
  server_name         = azurerm_postgresql_server.this.name
  value               = "off"
}

#resource "azurerm_postgresql_configuration" "connection_throttling" {
#  name                = "connection_throttling"
#  resource_group_name = azurerm_resource_group.this.name
#  server_name         = azurerm_postgresql_server.this.name
#  value               = "off"
#}
#
#resource "azurerm_postgresql_configuration" "log_retention_days" {
#  name                = "log_retention_days"
#  resource_group_name = azurerm_resource_group.this.name
#  server_name         = azurerm_postgresql_server.this.name
#  value               = 3
#}