resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-resource-group-green"
  location = var.location

  tags = var.tags
}