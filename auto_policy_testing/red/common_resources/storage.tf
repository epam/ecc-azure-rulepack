resource "azurerm_storage_account" "this" {
  name                     = "${module.naming.resource_prefix.storage}common${random_integer.this.result}"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = false

  tags = module.naming.default_tags
}

resource "azurerm_storage_container" "this" {
  name                  = "vhds"
  storage_account_id  = azurerm_storage_account.this.id
  container_access_type = "private"
}