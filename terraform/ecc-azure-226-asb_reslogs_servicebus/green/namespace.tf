resource "azurerm_servicebus_namespace" "this" {
  name                = "sbnamespace${var.prefix}green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Standard"

  tags = var.tags
}