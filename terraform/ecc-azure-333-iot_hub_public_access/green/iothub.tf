resource "azurerm_iothub" "this" {
  name                = "iot${var.prefix}green"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  public_network_access_enabled = false

  sku {
    name     = "F1"
    capacity = "1"
  }

  tags = var.tags
}