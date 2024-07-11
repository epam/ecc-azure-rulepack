output "network" {
  value = {
    networkinterface = azurerm_network_interface.this.id,
    networksecuritygroup = azurerm_network_security_group.this.id
  }
}