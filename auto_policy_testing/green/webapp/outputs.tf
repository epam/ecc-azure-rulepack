output "webapp" {
  value = {
    webapp = azurerm_linux_web_app.python1.id,
    ecc-azure-069-11_cis_app_last_java = azurerm_linux_web_app.java1.id,
    ecc-azure-069-51_cis_app_last_java = azurerm_linux_web_app.java1.id,
    ecc-azure-071-11_cis_app_last_php = azurerm_linux_web_app.php1.id,
    ecc-azure-071-51_cis_app_last_php = azurerm_linux_web_app.php1.id,
    ecc-azure-258-asb_remotedebug_web = azurerm_linux_web_app.remdeb.id,
    ecc-azure-379-cis_appservice_http_logs = azurerm_app_service.this.id,
  }
}