resource "azurerm_storage_account" "this" {
  name                     = "${var.prefix}sared"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_replication_type = "LRS"
  account_tier             = "Standard"
  allow_nested_items_to_be_public = false

  tags = var.tags
}

resource "azurerm_storage_container" "this" {
  name                  = "vhds"
  container_access_type = "private"
  storage_account_id    = azurerm_storage_account.this.id
}