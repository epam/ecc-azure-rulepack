resource "azurerm_api_management" "this" {
  name                = "red356apim"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  publisher_name      = "My Company2"
  publisher_email     = "company2@terraform.io"

  client_certificate_enabled = false
  
  sku_name = "Consumption_0"

  tags = var.tags
}