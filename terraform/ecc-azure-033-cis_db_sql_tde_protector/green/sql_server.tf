resource "azurerm_mssql_server" "sql_server" {
  name                         = "${var.prefix}azuresqlserver-green"
  resource_group_name          = azurerm_resource_group.this.name
  location                     = azurerm_resource_group.this.location
  version                      = "12.0"
  administrator_login          = random_string.this.result
  administrator_login_password = random_password.this.result
  tags                         = var.tags

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_mssql_server_transparent_data_encryption" "this" {
  server_id        = azurerm_mssql_server.sql_server.id
  key_vault_key_id = azurerm_key_vault_key.key.id

  depends_on = [
    azurerm_key_vault.this,
    azurerm_mssql_server.sql_server
  ]
}