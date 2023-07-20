resource "azurerm_monitor_diagnostic_setting" "this" {
  name               = "${var.prefix}settinggreen"
  target_resource_id = azurerm_logic_app_workflow.this.id
  storage_account_id = azurerm_storage_account.this.id

  log {
    category = "WorkflowRuntime"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 180
    }
  }
}

resource "azurerm_storage_account" "this" {
  name                     = "diag${var.prefix}sagreen"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
