output "kusto" {
  value = {
    kusto = azurerm_kusto_cluster.this.id
  }
}