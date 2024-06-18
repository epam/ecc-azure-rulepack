resource "azurerm_resource_group" "this" {
  name     = "common-rg-red${random_integer.this.result}"
  location = "eastus"
}