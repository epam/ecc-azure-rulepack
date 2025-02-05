resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-red2"
  location = var.location

  tags = var.tags
}