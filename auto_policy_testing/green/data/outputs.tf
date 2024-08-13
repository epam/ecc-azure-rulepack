output "data" {
  value = {
    databricks = azurerm_databricks_workspace.this.id,
    datafactory = azurerm_data_factory.this.id
  }
}