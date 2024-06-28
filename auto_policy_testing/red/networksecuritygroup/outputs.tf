output "networksecuritygroup" {
  value = {
    networksecuritygroup = azurerm_network_security_group.this.id
  }
}