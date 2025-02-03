resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-green1"
  location = var.location

  tags = var.tags
}