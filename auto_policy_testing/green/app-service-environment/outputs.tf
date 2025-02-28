output "app-service-environment" {
  value = {
    app-service-environment                  = azurerm_app_service_environment_v3.this.id
  }
}