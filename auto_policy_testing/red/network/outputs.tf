output "networkinterface" {
  value = {
    networkinterface = azurerm_network_interface.this.id
  }
}

output "networksecuritygroup" {
  value = {
    networksecuritygroup = azurerm_network_security_group.this.id
  }
}