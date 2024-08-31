output "vnet" {
  value = {
    vnet = azurerm_virtual_network.this.id,
    ecc-azure-176-asb_ddos_protection_enabled = azurerm_virtual_network.this1.id
  }
}