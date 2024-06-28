resource "azurerm_resource_group" "this" {
  name     = "networksecuritygroup-rg-red"
  location = var.location
}