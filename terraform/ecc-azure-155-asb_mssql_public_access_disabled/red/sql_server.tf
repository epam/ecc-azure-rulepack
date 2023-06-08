resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-red"
  location = var.location

  tags = var.tags
}

resource "azurerm_mssql_server" "this" {
  name                         = "sqlserver${var.prefix}-red"
  location                     = azurerm_resource_group.this.location
  resource_group_name          = azurerm_resource_group.this.name
  administrator_login          = random_string.this.result
  administrator_login_password = random_password.this.result
  minimum_tls_version          = "1.2"
  version                      = "12.0"

  public_network_access_enabled = true

  tags = var.tags
}