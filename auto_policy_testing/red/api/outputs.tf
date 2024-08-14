output "api" {
  value = {
    api-management = azurerm_api_management.this.id
  }
}