resource "azurerm_search_service" "this" {
  name                = "${var.prefix}-saserv-green"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "standard"
}