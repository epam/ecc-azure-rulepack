resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}_resource_group_red"
  location = var.location

  tags = var.tags
}