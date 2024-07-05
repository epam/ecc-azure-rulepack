resource "azurerm_storage_account" "this" {
  name                = "${module.naming.resource_prefix.storage}common${random_integer.this.result}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  account_tier              = "Standard"
  account_kind              = "StorageV2"
  account_replication_type  = "LRS"
  enable_https_traffic_only = true

  tags = module.naming.default_tags
}