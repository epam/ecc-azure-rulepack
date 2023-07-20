resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-red"
  location = "eastus"
}