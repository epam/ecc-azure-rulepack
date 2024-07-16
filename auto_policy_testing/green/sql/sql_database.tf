resource "azurerm_mssql_database" "this" {
  name           = module.naming.resource_prefix.sql-database
  server_id      = azurerm_mssql_server.this.id
  max_size_gb    = 4
  sku_name       = "BC_Gen5_2"
  zone_redundant = false

  tags = module.naming.default_tags
}