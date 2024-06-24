resource "azurerm_resource_group" "this" {
  name     = "webapp-rg-red"
  location = var.location
}