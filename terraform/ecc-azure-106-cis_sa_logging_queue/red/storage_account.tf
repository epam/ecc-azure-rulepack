resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-red"
  location = var.location
}

resource "azurerm_storage_account" "this" {
  name                     = "${var.prefix}sared"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_replication_type = "LRS"
  account_tier             = "Standard"

  tags = var.tags
}