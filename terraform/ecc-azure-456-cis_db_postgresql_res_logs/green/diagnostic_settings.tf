resource "azurerm_storage_account" "this" {
  name                     = "ds${var.prefix}green"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name               = "${var.prefix}dsgreen"
  target_resource_id = azurerm_postgresql_server.this.id
  storage_account_id = azurerm_storage_account.this.id

  enabled_log {
    category = "PostgreSQLLogs"
  }

  enabled_log {
    category = "QueryStoreRuntimeStatistics"
  }

  enabled_log {
    category = "QueryStoreWaitStatistics"
  }
}