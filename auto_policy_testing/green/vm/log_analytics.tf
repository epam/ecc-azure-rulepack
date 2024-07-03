resource "azurerm_log_analytics_workspace" "this" {
  name                = "log-vm-wrkspace"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = var.tags
}

locals {
  workspaceKey = azurerm_log_analytics_workspace.this.primary_shared_key
  workspaceId  = azurerm_log_analytics_workspace.this.workspace_id
}