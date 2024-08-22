resource "azurerm_storage_account" "this" {
  name                = "${module.naming.resource_prefix.storage}common${random_integer.this.result}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "LRS"
  https_traffic_only_enabled = true

  tags = module.naming.default_tags
}

resource "azurerm_storage_container" "this" {
  name                  = "acccommonstoragegreencontainer"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}