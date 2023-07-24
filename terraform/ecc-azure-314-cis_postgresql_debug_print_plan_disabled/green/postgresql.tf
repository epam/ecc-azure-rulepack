resource "azurerm_postgresql_server" "this" {
  name                = "${var.prefix}postgresqlserver-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  administrator_login          = random_string.this.result
  administrator_login_password = random_password.this.result

  sku_name   = "GP_Gen5_2"
  version    = "11"
  storage_mb = 51200

  ssl_enforcement_enabled = true

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_postgresql_configuration" "debug_print_plan" {
  name                = "debug_print_plan"
  resource_group_name = azurerm_resource_group.this.name
  server_name         = azurerm_postgresql_server.this.name
  value               = "off"
}