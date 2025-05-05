resource "azurerm_databricks_workspace" "this" {
  name                = "${var.prefix}databricks-green"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "premium"

  tags = var.tags
}