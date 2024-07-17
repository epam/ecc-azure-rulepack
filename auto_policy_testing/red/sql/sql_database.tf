resource "azurerm_mssql_database" "this" {
  name           = module.naming.resource_prefix.sql-database
  server_id      = azurerm_mssql_server.this.id
  sku_name       = "DW100c"
  zone_redundant = false

  transparent_data_encryption_enabled = false

  tags = module.naming.default_tags
}