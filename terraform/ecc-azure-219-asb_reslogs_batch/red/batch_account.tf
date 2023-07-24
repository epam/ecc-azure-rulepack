resource "azurerm_batch_account" "this" {
  name                 = "batchac${var.prefix}red"
  resource_group_name  = azurerm_resource_group.this.name
  location             = azurerm_resource_group.this.location
  pool_allocation_mode = "BatchService"
  storage_account_id   = azurerm_storage_account.this.id
}

resource "azurerm_storage_account" "this" {
  name                     = "diag${var.prefix}sared"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}