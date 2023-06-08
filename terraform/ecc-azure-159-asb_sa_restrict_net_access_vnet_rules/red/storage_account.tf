resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-red"
  location = var.location
}

resource "azurerm_storage_account" "this" {
  name                = "${var.prefix}storageaccred"
  resource_group_name = azurerm_resource_group.this.name

  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  network_rules {
    default_action = "Deny"
  }

  tags = var.tags
}