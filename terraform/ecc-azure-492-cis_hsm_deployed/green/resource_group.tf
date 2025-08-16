resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-green21"
  location = var.location

  tags = var.tags
}