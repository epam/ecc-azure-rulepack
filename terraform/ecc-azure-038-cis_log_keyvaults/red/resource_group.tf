resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-resource-group-red"
  location = var.location

  tags = var.tags
}