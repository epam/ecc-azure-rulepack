output "api" {
  value = {
    api-management                  = azurerm_api_management.this.id,
    ecc-azure-143-asb_api_mgmt_vnet = azurerm_api_management.this1.id
  }
}