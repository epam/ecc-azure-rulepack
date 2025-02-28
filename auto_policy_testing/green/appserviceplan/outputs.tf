output "appserviceplan" {
  value = {
    appserviceplan = azurerm_service_plan.this.id
  }
}