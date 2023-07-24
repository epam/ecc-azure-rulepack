resource "azurerm_postgresql_server" "this" {
  name                = "postgresqlserver${var.prefix}-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  administrator_login          = random_string.this.result
  administrator_login_password = random_password.this.result

  sku_name   = "GP_Gen5_2"
  storage_mb = 5120
  version    = "9.6"

  auto_grow_enabled                = true
  backup_retention_days            = 7
  geo_redundant_backup_enabled     = false
  public_network_access_enabled    = false
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"

  threat_detection_policy {
    enabled = true
  }

  tags = var.tags
}