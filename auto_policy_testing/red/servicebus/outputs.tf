output "servicebus" {
  value = {
    servicebus-namespace = azurerm_servicebus_namespace.this.id
  }
}