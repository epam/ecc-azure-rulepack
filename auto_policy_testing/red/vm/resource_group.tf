resource "azurerm_resource_group" "this" {
  name     = "VM-RG-RED"
  location = var.location
  tags     = var.tags
}