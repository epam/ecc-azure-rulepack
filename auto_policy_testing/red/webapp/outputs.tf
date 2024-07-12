output "webapp" {
  value = {
    webapp = azurerm_linux_web_app.this.id,
    ecc-azure-180-asb_func_app_managed_identity = azurerm_linux_function_app.this.id,
    ecc-azure-237-asb_cors_func = azurerm_linux_function_app.this.id,
    ecc-azure-241-asb_certif_func = azurerm_linux_function_app.this.id,
    ecc-azure-257-asb_remotedebug_func = azurerm_linux_function_app.this.id,
    ecc-azure-258-asb_remotedebug_web = azurerm_linux_web_app.this2.id,
    ecc-azure-267-asb_java_funcapp = azurerm_linux_function_app.this2.id,
    ecc-azure-270-asb_python_funcapp = azurerm_linux_function_app.this.id,
    ecc-azure-298-function_app_service_logging = azurerm_linux_function_app.this.id,
    ecc-azure-299-function_app_health_check = azurerm_linux_function_app.this.id
  }
}