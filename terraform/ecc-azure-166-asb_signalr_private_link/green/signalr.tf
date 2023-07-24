resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-green"
  location = var.location

  tags = var.tags
}

resource "azurerm_signalr_service" "this" {
  name                = "res${var.prefix}green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

  sku {
    name     = "Standard_S1"
    capacity = 1
  }

  tags = var.tags
}