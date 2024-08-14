output "data" {
  value = {
    databricks  = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.terraform_remote_state.common.outputs.resource_group}/providers/Microsoft.Databricks/workspaces/${azurerm_databricks_workspace.this.name}",
    datafactory = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/green-infrastructure-ci/providers/Microsoft.DataFactory/factories/${azurerm_data_factory.this.name}"
  }
}