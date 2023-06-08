resource "azurerm_mssql_server" "this" {
  name                         = "${var.prefix}azuresqlserver-green"
  resource_group_name          = azurerm_resource_group.this.name
  location                     = azurerm_resource_group.this.location
  version                      = "12.0"
  administrator_login          = random_string.this.result
  administrator_login_password = random_password.this.result
  minimum_tls_version          = "1.2"

  tags = var.tags
}