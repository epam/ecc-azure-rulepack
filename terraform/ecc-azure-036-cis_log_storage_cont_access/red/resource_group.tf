resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-red"
  location = var.location
}

data "azurerm_client_config" "current" {}