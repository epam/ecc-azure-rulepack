resource "azurerm_container_registry" "this" {
  name                = "${var.prefix}containerRegistryred"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Premium"
  admin_enabled       = false

  tags = var.tags
}