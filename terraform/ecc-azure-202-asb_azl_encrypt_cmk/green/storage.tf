resource "azurerm_storage_account" "this" {
  name                     = "storage${var.prefix}green"
  location                 = azurerm_resource_group.this.location
  resource_group_name      = azurerm_resource_group.this.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}