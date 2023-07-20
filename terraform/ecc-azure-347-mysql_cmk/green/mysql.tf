resource "azurerm_mysql_server" "this" {
  name                = "${var.prefix}-mysql-server-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  administrator_login          = random_string.this.result
  administrator_login_password = random_password.this.result

  sku_name   = "GP_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
  public_network_access_enabled    = false

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_mysql_server_key" "this" {
  server_id        = azurerm_mysql_server.this.id
  key_vault_key_id = azurerm_key_vault_key.this.id
}