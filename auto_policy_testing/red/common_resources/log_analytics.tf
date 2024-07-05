data "azurerm_client_config" "current" {}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "${module.naming.resource_prefix.loganalytics}-common"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = module.naming.default_tags
}

