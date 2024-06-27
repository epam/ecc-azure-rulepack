output "networkinterface" {
  value = {
    networkinterface = azurerm_network_interface.this.id
  }
}