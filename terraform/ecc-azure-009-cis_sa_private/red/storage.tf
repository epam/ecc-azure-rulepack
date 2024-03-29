resource "azurerm_storage_account" "this" {
  name                     = "${var.prefix}sared"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

resource "azurerm_storage_container" "container1" {
  name                  = "${var.prefix}sc1red"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "container"
}

resource "azurerm_storage_container" "container2" {
  name                  = "${var.prefix}sc2red"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "blob"
}
