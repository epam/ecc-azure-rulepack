output "webapp" {
  value = {
    webapp = azurerm_linux_web_app.this.id
  }
}