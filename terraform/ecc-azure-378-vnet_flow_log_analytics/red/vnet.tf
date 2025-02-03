resource "azurerm_virtual_network" "this" {
  name                = "${var.prefix}vnetred"
  address_space       = ["10.0.0.0/24"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  
  tags                = var.tags
}