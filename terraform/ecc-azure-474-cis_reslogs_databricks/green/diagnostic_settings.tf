resource "azurerm_storage_account" "this" {
  name                     = "diag${var.prefix}sagreen"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name               = "${var.prefix}settinggreen"
  target_resource_id = azurerm_databricks_workspace.this.id
  storage_account_id = azurerm_storage_account.this.id

  enabled_log {
    category = "accounts"
  }

  enabled_log {
    category = "filesystem"
  }

  enabled_log {
    category = "clusters"
  }

  enabled_log {
    category = "notebook"
  }

  enabled_log {
    category = "jobs"
  }
}
