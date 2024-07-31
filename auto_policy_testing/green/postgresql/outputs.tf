output "postgresql" {
  value = {
    postgresql-server = azurerm_postgresql_server.this.id
  }
}