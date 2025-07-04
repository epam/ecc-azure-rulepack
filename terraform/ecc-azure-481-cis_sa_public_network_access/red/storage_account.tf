resource "azurerm_storage_account" "this" {
  name                     = "sa${var.prefix}red"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false

  public_network_access_enabled = true

  tags = var.tags
}