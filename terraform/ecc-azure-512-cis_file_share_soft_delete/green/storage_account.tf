resource "azurerm_storage_account" "this" {
  name                     = "sa${var.prefix}green"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false

  share_properties {
    retention_policy {
      days = 14
    }
  }

  tags = var.tags
}

resource "azurerm_storage_share" "this" {
  name               = "fileshare${var.prefix}green"
  storage_account_id = azurerm_storage_account.this.id
  quota              = 10
}
