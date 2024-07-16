output "sql" {
  value = {
    sql-database  = azurerm_mssql_database.this.id,
    sql-server    = azurerm_mssql_server.this.id
  }
}