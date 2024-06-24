resource "azurerm_storage_account" "this" {
  name                     = "diagappsagreen"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name               = "appsettinggreen"
  target_resource_id = azurerm_linux_web_app.this.id
  storage_account_id = azurerm_storage_account.this.id

  enabled_log {
    category = "AppServiceHTTPLogs"
  }
}
