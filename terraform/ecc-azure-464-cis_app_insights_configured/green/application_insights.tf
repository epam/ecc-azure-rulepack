resource "azurerm_log_analytics_workspace" "this" {
  name                = "ecc-azure-${var.prefix}-log-analytics"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "PerGB2018"

  tags = var.tags
}

resource "azurerm_application_insights" "this" {
  name                = "ecc-azure-${var.prefix}-app-insights"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  workspace_id        = azurerm_log_analytics_workspace.this.id
  application_type    = "web"

  tags = var.tags
}