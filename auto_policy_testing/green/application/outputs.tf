output "application" {
  value = {
    application-gateway = azurerm_application_gateway.this.id
  }
}