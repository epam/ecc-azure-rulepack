resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-red"
  location = var.location

  tags = var.tags
}

data "azurerm_client_config" "current" {}