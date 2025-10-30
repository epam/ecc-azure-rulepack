resource "azurerm_public_ip" "this" {
  name                = "${var.prefix}pip_green"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  allocation_method   = "Static"
  sku = "Standard"

  tags = var.tags
}
