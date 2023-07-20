resource "azurerm_batch_account" "this" {
  name                 = "batchac${var.prefix}green"
  resource_group_name  = azurerm_resource_group.this.name
  location             = azurerm_resource_group.this.location
  pool_allocation_mode = "BatchService"
  storage_account_id   = azurerm_storage_account.this.id
}