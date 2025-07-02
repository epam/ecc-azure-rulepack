resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-green"
  location = var.location
  tags     = var.tags
}

resource "azurerm_management_lock" "this" {
  name       = "rg${var.prefix}greenlock"
  scope      = azurerm_resource_group.this.id
  lock_level = "ReadOnly"
  notes      = "This Resource Group can't be edited!"
}