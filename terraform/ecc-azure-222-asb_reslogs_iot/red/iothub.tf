resource "azurerm_iothub" "this" {
  name                = "iot${var.prefix}red"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  sku {
    name     = "S1"
    capacity = "1"
  }
}