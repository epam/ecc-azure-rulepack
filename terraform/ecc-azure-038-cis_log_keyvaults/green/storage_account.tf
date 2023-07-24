resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-resource-group-green"
  location = var.location

  tags = var.tags
}

resource "azurerm_storage_account" "this" {
  name                     = "${var.prefix}storageaccgreen"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}