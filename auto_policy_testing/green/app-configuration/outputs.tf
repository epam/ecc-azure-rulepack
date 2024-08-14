output "app-configuration" {
  value = {
    app-configuration = azurerm_app_configuration.this.id
  }
}