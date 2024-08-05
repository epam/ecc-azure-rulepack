output "spring" {
  value = {
    spring-service-instance = azurerm_spring_cloud_service.this.id
  }
}