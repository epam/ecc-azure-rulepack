resource "azurerm_mssql_server" "this" {
  name                         = "${var.prefix}-sql-red"
  resource_group_name          = azurerm_resource_group.this.name
  location                     = azurerm_resource_group.this.location
  version                      = "12.0"
  administrator_login          = random_string.this.result
  administrator_login_password = random_password.this.result

  tags = var.tags
}

resource "azurerm_mssql_firewall_rule" "this" {
  name             = "${var.prefix}-fwrule-red"
  server_id        = azurerm_mssql_server.this.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.1"
}