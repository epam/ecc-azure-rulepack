resource "azurerm_recovery_services_vault" "this" {
  name                = "rs${var.prefix}-vault-red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Standard"

  tags                = var.tags
}