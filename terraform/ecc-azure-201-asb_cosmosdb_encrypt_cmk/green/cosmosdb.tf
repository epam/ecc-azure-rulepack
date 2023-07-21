resource "azurerm_cosmosdb_account" "this" {
  name                = "green201cosmosdb${random_integer.this.result}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  key_vault_key_id    = azurerm_key_vault_key.this.versionless_id

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }
  geo_location {
    location          = azurerm_resource_group.this.location
    failover_priority = 0
  }
  depends_on = [
    azurerm_key_vault.this,
    azurerm_key_vault_key.this
  ]

}