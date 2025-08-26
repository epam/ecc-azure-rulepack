resource "azurerm_recovery_services_vault" "this" {
  name                = "rs${var.prefix}-vault-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "Standard"

  public_network_access_enabled = false

  tags                = var.tags
}