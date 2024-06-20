output "storage" {
  value = {
    storage = azurerm_storage_account.this.id 
  }
}