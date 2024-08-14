output "alert" {
  value = {
    alert-logs = azurerm_monitor_activity_log_alert.this.id
  }
}