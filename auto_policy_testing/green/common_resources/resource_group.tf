resource "azurerm_resource_group" "this" {
  name     = "common-rg-green${random_integer.this.result}"
  location = "${var.location}"
}