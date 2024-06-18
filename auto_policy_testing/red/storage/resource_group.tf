resource "azurerm_resource_group" "this" {
  name     = "storage-rg-red"
  location = var.location
}