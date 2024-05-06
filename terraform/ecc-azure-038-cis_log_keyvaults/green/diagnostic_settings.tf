resource "azurerm_monitor_diagnostic_setting" "this" {
  name               = "${var.prefix}diagnostic-settings-green"
  target_resource_id = azurerm_key_vault.this.id
  storage_account_id = azurerm_storage_account.this.id

  enabled_log {
    category = "AuditEvent"
  }
  
  depends_on = [
    azurerm_storage_account.this,
    azurerm_key_vault.this
  ]

}