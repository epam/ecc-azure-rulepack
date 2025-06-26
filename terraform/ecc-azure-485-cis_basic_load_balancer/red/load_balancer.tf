resource "azurerm_lb" "this" {
  name                = "${var.prefix}-lb-red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku = "Basic"

  tags = var.tags
}

