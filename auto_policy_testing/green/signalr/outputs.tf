output "signalr" {
  value = {
    signalr = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.terraform_remote_state.common.outputs.resource_group}/providers/Microsoft.SignalRService/SignalR/${azurerm_signalr_service.this.name}"
  }
}