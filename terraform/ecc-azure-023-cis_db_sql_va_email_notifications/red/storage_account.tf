resource "azurerm_storage_account" "this" {
  name                     = "${var.prefix}sared"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

resource "azurerm_storage_container" "this" {
  name                  = "${var.prefix}scred"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
  depends_on            = [azurerm_mssql_server.this]
}