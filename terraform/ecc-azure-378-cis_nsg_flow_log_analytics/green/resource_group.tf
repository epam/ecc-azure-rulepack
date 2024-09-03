resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-green"
  location = var.location
}

resource "azurerm_resource_group" "this1" {
  name     = "${var.prefix}-rg-green1"
  location = var.location
}