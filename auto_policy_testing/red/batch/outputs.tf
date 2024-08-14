output "batch" {
  value = {
    batch = azurerm_batch_account.this.id
  }
}