output "mysql" {
  value = {
    mysql-flexibleserver = azurerm_mysql_flexible_server.this.id,
    ecc-azure-277-asb_geo_mysql = azurerm_mysql_flexible_server.geo.id
  }
  sensitive = true
}