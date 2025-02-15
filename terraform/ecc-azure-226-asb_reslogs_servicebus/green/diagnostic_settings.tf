resource "azurerm_storage_account" "this" {
  name                     = "diag${var.prefix}sagreen"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name               = "${var.prefix}settinggreen"
  target_resource_id = azurerm_servicebus_namespace.this.id
  storage_account_id = azurerm_storage_account.this.id

  enabled_log {
    category = "ApplicationMetricsLogs"
  }

  enabled_log {
    category = "DiagnosticErrorLogs"
  }
  
  enabled_log {
    category = "OperationalLogs"
  }
  
  enabled_log {
    category = "RuntimeAuditLogs"
  }
  
  enabled_log {
    category = "VNetAndIPFilteringLogs"
  }
}
