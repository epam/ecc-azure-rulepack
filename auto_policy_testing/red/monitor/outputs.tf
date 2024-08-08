output "monitor" {
  value = {
    monitor-log-profile = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/providers/microsoft.insights/logprofiles/${azurerm_monitor_log_profile.this.name}"
  }
}