resource "azurerm_resource_group" "this" {
  name     = "${module.naming.resource_prefix.resourcegroup}"
  location = "eastus"

  tags = module.naming.default_tags
}

resource "azurerm_storage_account" "this" {
  name                      = "${module.naming.resource_prefix.storage}storage${random_integer.this.result}"
  location                  = "eastus" #this option required for 291 policy
  resource_group_name       = azurerm_resource_group.this.name
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = false

  network_rules {
    default_action = "Allow"
    bypass         = ["None"]
  }

  min_tls_version = "TLS1_0"

  tags = module.naming.default_tags
}

resource "azurerm_storage_container" "container1" {
  name                  = "${random_integer.this.result}sc1red"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "container"
}

resource "azurerm_storage_container" "container2" {
  name                  = "${random_integer.this.result}sc2red"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "blob"
}
