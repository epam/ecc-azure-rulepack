resource "azurerm_storage_account" "this" {
  name                     = "sa${var.prefix}red"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_batch_account" "this" {
  name                 = "batch${var.prefix}red"
  resource_group_name  = azurerm_resource_group.this.name
  location             = azurerm_resource_group.this.location
  pool_allocation_mode = "BatchService"
  storage_account_id   = azurerm_storage_account.this.id

  tags = var.tags
}