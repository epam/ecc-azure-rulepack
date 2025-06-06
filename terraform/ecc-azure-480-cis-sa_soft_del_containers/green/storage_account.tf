resource "azurerm_storage_account" "this" {
  name                     = "${var.prefix}sagreen"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false

  blob_properties {
    delete_retention_policy {
      days = 5
    }
    container_delete_retention_policy {
      days = 7
    }
  }

  tags = var.tags
}

