output "storage" {
  value = {
    storageid = azurerm_storage_account.this.id
  }
}