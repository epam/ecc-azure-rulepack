resource "azurerm_cosmosdb_account" "this" {
  name                          = "${module.naming.resource_prefix.cosmosdb}-${random_integer.this.result}"
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group
  offer_type                    = "Standard"
  kind                          = "GlobalDocumentDB"

  access_key_metadata_writes_enabled = true

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
    location          = data.terraform_remote_state.common.outputs.location
    failover_priority = 0
  }

  tags = module.naming.default_tags
}