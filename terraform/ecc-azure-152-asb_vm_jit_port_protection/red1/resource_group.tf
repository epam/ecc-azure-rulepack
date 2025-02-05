resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-red1"
  location = var.location

  tags = var.tags
}