output "vnet" {
  value = {
    vnet = azurerm_virtual_network.this.id
  }
}