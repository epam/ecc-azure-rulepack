resource "azurerm_resource_group" "this" {
  name     = "webapp-rg-green"
  location = var.location
}