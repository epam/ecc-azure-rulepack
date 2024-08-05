output "signalr" {
  value = {
    signalr = azurerm_signalr_service.this.id 
  }
}