resource "azurerm_logic_app_workflow" "this" {
  name                = "la${var.prefix}green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}