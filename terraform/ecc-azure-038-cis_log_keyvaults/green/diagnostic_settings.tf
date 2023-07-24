resource "azurerm_monitor_diagnostic_setting" "this" {
  name               = "${var.prefix}diagnostic-settings-green"
  target_resource_id = azurerm_key_vault.this.id
  storage_account_id = azurerm_storage_account.this.id

  log {
    category = "AuditEvent"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 180
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = false
    }
  }

  depends_on = [
    azurerm_storage_account.this,
    azurerm_key_vault.this
  ]

}