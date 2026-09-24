resource "azurerm_storage_account" "this" {
  name                     = "storage${var.prefix}greencustodian"
  location                 = azurerm_resource_group.this.location
  resource_group_name      = azurerm_resource_group.this.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false
  tags                     = var.tags
}