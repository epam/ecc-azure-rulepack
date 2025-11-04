resource "azurerm_recovery_services_vault" "this" {
  name                = "rs${var.prefix}-vault-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Standard"

  identity {
    type = "SystemAssigned"
  }

  encryption {
    key_id                            = azurerm_key_vault_key.this.id
    infrastructure_encryption_enabled = true
  }

  tags                = var.tags
}