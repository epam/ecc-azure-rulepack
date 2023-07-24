resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-red"
  location = var.location
  tags     = var.tags
}

resource "azurerm_postgresql_server" "this" {
  name                = "${var.prefix}postgres-red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  administrator_login          = random_string.this.result
  administrator_login_password = random_password.this.result

  sku_name   = "B_Gen5_1"
  version    = "9.6"
  storage_mb = 5120

  public_network_access_enabled    = true
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"

  tags = var.tags
}

resource "azurerm_postgresql_firewall_rule" "this" {
  name                = "AllowAllAzureIps"
  resource_group_name = azurerm_resource_group.this.name
  server_name         = azurerm_postgresql_server.this.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}