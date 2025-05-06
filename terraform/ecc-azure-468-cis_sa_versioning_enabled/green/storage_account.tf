resource "azurerm_storage_account" "this" {
  name                     = "sa${var.prefix}green"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  allow_nested_items_to_be_public = false

  blob_properties {
    versioning_enabled = true
  }
  
  tags                     = var.tags
}