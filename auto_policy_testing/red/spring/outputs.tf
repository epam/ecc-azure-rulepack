output "spring" {
  value = {
    spring = azurerm_spring_cloud_service.this.id
  }
}