resource "azurerm_eventgrid_topic" "this" {
  name                = "${var.prefix}egtopicred"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tags                = var.tags
}