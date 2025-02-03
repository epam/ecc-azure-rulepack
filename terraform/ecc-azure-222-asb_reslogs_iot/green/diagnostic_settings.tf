resource "azurerm_storage_account" "this" {
  name                     = "diag${var.prefix}sagreen"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name               = "${var.prefix}settinggreen"
  target_resource_id = azurerm_iothub.this.id
  storage_account_id = azurerm_storage_account.this.id

  enabled_log {
    category = "Connections"
  }

  enabled_log {
    category = "DeviceTelemetry"
  }
  
  enabled_log {
    category = "C2DCommands"
  }
  enabled_log {
    category = "DeviceIdentityOperations"
  }
  enabled_log {
    category = "FileUploadOperations"
  }
  enabled_log {
    category = "Routes"
  }
  enabled_log {
    category = "D2CTwinOperations"
  }
  enabled_log {
    category = "C2DTwinOperations"
  }
  enabled_log {
    category = "TwinQueries"
  }
  enabled_log {
    category = "JobsOperations"
  }
  enabled_log {
    category = "DirectMethods"
  }
  enabled_log {
    category = "DistributedTracing"
  }
  enabled_log {
    category = "Configurations"
  }
  enabled_log {
    category = "DeviceStreams"
  }
}
