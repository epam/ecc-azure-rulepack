output "webapp" {
  value = {
    webapp = azurerm_linux_web_app.this.id,
    ecc-azure-069-cis_app_last_java = azurerm_linux_web_app.this2.id,
    ecc-azure-071-cis_app_last_php = azurerm_linux_web_app.this3.id,
    ecc-azure-258-asb_remotedebug_web = azurerm_linux_web_app.remdeb.id
  }
}