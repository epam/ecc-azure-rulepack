resource "azurerm_network_watcher" "this" {
  name                = "ecc-azure-${var.prefix}-vnetflowloganalytics-nw"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  tags = var.tags
}

resource "azurerm_virtual_network" "this" {
  name                = "${var.prefix}vnetgreen"
  address_space       = ["10.0.0.0/24"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  
  tags                = var.tags
}



resource "azurerm_storage_account" "this" {
  name                = "eccazure${var.prefix}sa"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "LRS"
  allow_nested_items_to_be_public = false

  tags = var.tags
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "ecc-azure-${var.prefix}-vnetflowloganalytics-law"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "PerGB2018"

  tags = var.tags
}

resource "azurerm_network_watcher_flow_log" "this" {
  network_watcher_name = azurerm_network_watcher.this.name
  resource_group_name  = azurerm_resource_group.this.name
  name                 = "ecc-azure-${var.prefix}-vnetflowloganalytics-log"

  target_resource_id   = azurerm_virtual_network.this.id

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

  tags = var.tags
}

