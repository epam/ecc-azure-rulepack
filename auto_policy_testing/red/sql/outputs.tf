output "sql" {
  value = {
    sql-database  = azurerm_mssql_database.this.id,
    sql-server    = azurerm_mssql_server.this.id,
    sql-managed-instance = azurerm_mssql_managed_instance.this.id,
    ecc-azure-015-cis_db_auditing_90d = azurerm_mssql_server.audit.id,
    ecc-azure-295-sql_avoid_ad_admin_name = azurerm_mssql_server.audit.id
  }
}