data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                       = "kv${var.prefix}red${random_integer.this.result}"
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = false

  tags = var.tags
}