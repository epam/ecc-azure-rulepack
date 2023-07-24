resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-green"
  location = var.location
  tags     = var.tags
}


resource "azurerm_network_watcher" "this" {
  name                = "${var.prefix}-nw-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}