resource "azurerm_cosmosdb_account" "this" {
  name                = "cdb${var.prefix}-${random_integer.ri.result}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  enable_automatic_failover = true

  is_virtual_network_filter_enabled = true

  ip_range_filter = "127.0.0.1"

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "MongoDBv3.4"
  }

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 301
    max_staleness_prefix    = 100001
  }

  geo_location {
    location          = "eastus2"
    failover_priority = 1
  }

  geo_location {
    location          = azurerm_resource_group.this.location
    failover_priority = 0
  }
}