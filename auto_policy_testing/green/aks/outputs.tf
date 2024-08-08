output "aks" {
  value = {
    aks = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourcegroups/${data.terraform_remote_state.common.outputs.resource_group}/providers/Microsoft.ContainerService/managedClusters/${azurerm_kubernetes_cluster.this.name}"
    ecc-azure-144-asb_aks_auth_ip_ranges = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourcegroups/${data.terraform_remote_state.common.outputs.resource_group}/providers/Microsoft.ContainerService/managedClusters/${azurerm_kubernetes_cluster.this1.name}"
  }
}