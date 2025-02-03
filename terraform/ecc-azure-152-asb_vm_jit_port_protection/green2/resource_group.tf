resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-green2"
  location = var.location

  tags = var.tags
}