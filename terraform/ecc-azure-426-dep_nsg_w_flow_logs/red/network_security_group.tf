resource "azurerm_network_security_group" "this" {
  name                = "${var.prefix}-nsg-red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  tags = var.tags
}

resource "azurerm_storage_account" "this" {
  name                = "eccazure426sa"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "LRS"
  allow_nested_items_to_be_public = false

  tags = var.tags
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "ecc-azure-426-cisnsgflowloganalytics-law"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "PerGB2018"

  tags = var.tags
}

resource "azurerm_network_watcher_flow_log" "this" {
  network_watcher_name = "NetworkWatcher_eastus"
  resource_group_name  = "NetworkWatcherRG"
  name                 = "ecc-azure-426-cisnsgflowloganalytics-log"

  network_security_group_id = azurerm_network_security_group.this.id
  storage_account_id        = azurerm_storage_account.this.id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = 7
  }

  traffic_analytics {
    enabled               = true
    workspace_id          = azurerm_log_analytics_workspace.this.workspace_id
    workspace_region      = azurerm_log_analytics_workspace.this.location
    workspace_resource_id = azurerm_log_analytics_workspace.this.id
    interval_in_minutes   = 10
  }
}

