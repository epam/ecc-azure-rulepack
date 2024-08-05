output "spring" {
  value = {
    spring-service-instance = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.terraform_remote_state.common.outputs.resource_group}/providers/Microsoft.AppPlatform/Spring/${azurerm_spring_cloud_service.this.name}"
  }
}