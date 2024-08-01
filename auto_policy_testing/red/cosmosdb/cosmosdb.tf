resource "azurerm_cosmosdb_account" "this" {
  name                          = "${module.naming.resource_prefix.cosmosdb}-${random_integer.this.result}"
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group
  offer_type                    = "Standard"
  kind                          = "GlobalDocumentDB"

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  geo_location {
    location          = data.terraform_remote_state.common.outputs.location
    failover_priority = 0
  }

  access_key_metadata_writes_enabled = true

  tags = module.naming.default_tags
}