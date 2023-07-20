resource "azurerm_storage_account" "this" {
  name                     = "${var.prefix}sagreen"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_monitor_log_profile" "this" {
  name               = "log-profile-green"
  storage_account_id = azurerm_storage_account.this.id
  locations          = [var.location]

  categories = [
    "Action",
    "Delete",
    "Write",
  ]

  retention_policy {
    enabled = false
  }

}