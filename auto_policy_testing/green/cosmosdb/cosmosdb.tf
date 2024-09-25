resource "azurerm_cosmosdb_account" "this" {
  name                          = "${module.naming.resource_prefix.cosmosdb}-${random_integer.this.result}"
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group
  offer_type                    = "Standard"
  kind                          = "MongoDB"

  capabilities {
    name = "EnableAggregationPipeline"
  }

  capabilities {
    name = "mongoEnableDocLevelTTL"
  }

  capabilities {
    name = "MongoDBv3.4"
  }

  capabilities {
    name = "EnableMongo"
  }

  is_virtual_network_filter_enabled = true

  ip_range_filter = "127.0.0.1"

  key_vault_key_id = azurerm_key_vault_key.this.versionless_id

  access_key_metadata_writes_enabled = false

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 301
    max_staleness_prefix    = 100001
  }

  geo_location {
    location          = data.terraform_remote_state.common.outputs.location
    failover_priority = 0
  }

  tags = module.naming.default_tags
}