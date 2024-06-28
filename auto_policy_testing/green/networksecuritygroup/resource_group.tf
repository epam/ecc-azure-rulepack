resource "azurerm_resource_group" "this" {
  name     = "networksecuritygroup-rg-green"
  location = var.location
}