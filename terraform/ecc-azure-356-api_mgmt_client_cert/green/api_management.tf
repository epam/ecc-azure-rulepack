resource "azurerm_api_management" "this" {
  name                = "green356apim"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  publisher_name      = "My Company1"
  publisher_email     = "company1@terraform.io"

  client_certificate_enabled = true
  
  sku_name = "Consumption_0"

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_api_management_certificate" "example" {
  name                = "green-cert"
  api_management_name = azurerm_api_management.this.name
  resource_group_name = azurerm_resource_group.this.name

  key_vault_secret_id = azurerm_key_vault_certificate.this.secret_id
}