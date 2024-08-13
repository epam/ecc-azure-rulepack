output "data" {
  value = {
    databricks  = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/red-infrastructure-ci/providers/Microsoft.DataFactory/factories/${azurerm_databricks_workspace.this.name}",
    datafactory = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/red-infrastructure-ci/providers/Microsoft.DataFactory/factories/${azurerm_data_factory.this.name}"
  }
}