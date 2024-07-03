resource "azurerm_resource_group" "this" {
  name     = "VM-RG-GREEN"
  location = var.location
  tags     = var.tags
}