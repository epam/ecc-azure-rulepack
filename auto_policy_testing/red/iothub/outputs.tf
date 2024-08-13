output "iothub" {
  value = {
    iothub = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.terraform_remote_state.common.outputs.resource_group}/providers/Microsoft.Devices/IotHubs/${azurerm_iothub.this.name}"
  }
}