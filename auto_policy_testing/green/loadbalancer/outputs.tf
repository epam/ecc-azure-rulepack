output "loadbalancer" {
  value = {
    loadbalancer = azurerm_lb.this.id
  }
}