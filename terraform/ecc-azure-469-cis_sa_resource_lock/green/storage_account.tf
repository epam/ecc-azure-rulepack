resource "azurerm_storage_account" "this" {
  name                     = "sa${var.prefix}green"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false

  tags = var.tags
}

resource "azurerm_management_lock" "this" {
  name       = "sa${var.prefix}greenlock"
  scope      = azurerm_storage_account.this.id
  lock_level = "CanNotDelete"
  notes      = "This Storage Account can't be deleted!"
}