output "sql" {
  value = {
    sql-database         = azurerm_mssql_database.this.id,
    sql-server           = azurerm_mssql_server.this.id,
    sql-managed-instance = azurerm_mssql_managed_instance.this.id
  }
}