output "container" {
  value = {
    container-registry = azurerm_container_registry.this.id
  }
}