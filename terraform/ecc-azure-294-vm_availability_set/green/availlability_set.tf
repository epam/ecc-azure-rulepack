resource "azurerm_availability_set" "this" {
  name                = "${var.prefix}-aset"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  tags = var.tags
}