output "application" {
  value = {
    application-gateway           = azurerm_application_gateway.this.id,
    ecc-azure-340-appgw_waf_log4j = azurerm_application_gateway.this1.id
  }
}