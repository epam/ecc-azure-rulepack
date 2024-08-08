output "kusto" {
  value = {
    kusto = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.terraform_remote_state.common.outputs.resource_group}/providers/Microsoft.Kusto/Clusters/${azurerm_kusto_cluster.this.name}"
  }
}