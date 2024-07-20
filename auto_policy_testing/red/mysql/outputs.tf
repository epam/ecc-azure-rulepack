output "mysql" {
  value = {
    mysql-flexibleserver = azurerm_mysql_flexible_server.this.id
  }
  sensitive = true
}