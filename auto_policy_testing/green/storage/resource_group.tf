resource "azurerm_resource_group" "this" {
  name     = "storage-rg-green"
  location = var.location
}