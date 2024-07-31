output "cosmosdb" {
  value = {
    cosmosdb = azurerm_cosmosdb_account.this.id
  }
}