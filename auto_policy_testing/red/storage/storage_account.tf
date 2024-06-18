resource "azurerm_storage_account" "this" {
  name                      = "${random_string.this.result}sared"
  resource_group_name       = azurerm_resource_group.this.name
  location                  = azurerm_resource_group.this.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  enable_https_traffic_only = false

  network_rules {
    default_action = "Allow"
  }

  tags = var.tags
}

resource "azurerm_storage_container" "container1" {
  name                  = "${random_string.this.result}sc1red"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "container"
}

resource "azurerm_storage_container" "container2" {
  name                  = "${random_string.this.result}sc2red"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "blob"
}
