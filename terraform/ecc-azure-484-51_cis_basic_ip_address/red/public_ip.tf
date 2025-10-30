resource "azurerm_public_ip" "this" {
  name                = "${var.prefix}pip_red"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  allocation_method   = "Dynamic"
  sku = "Basic"

  tags = var.tags
}