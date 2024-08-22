output "service-fabric" {
  value = {
    service-fabric-cluster = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourcegroups/${data.terraform_remote_state.common.outputs.resource_group}/providers/Microsoft.ServiceFabric/clusters/${azurerm_service_fabric_cluster.name}"
  }
}