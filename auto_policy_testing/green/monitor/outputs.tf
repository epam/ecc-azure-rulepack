output "monitor" {
  value = {
    monitor-log-profile = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.terraform_remote_state.common.outputs.resource_group}/providers/microsoft.insights/logprofiles/${azurerm_monitor_log_profile.this.name}"
  }
}