resource "azurerm_mysql_server" "this" {
  name                = "${var.prefix}-mysql-server-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  administrator_login          = random_string.this.result
  administrator_login_password = random_password.this.result

  sku_name   = "GP_Gen5_8"
  storage_mb = 5120
  version    = "5.7"

  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_1"
  infrastructure_encryption_enabled = false

  threat_detection_policy {
    enabled = true
  }
}