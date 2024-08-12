output "iothub" {
  value = {
    iothub = azurerm_iothub.this.id
  }
}