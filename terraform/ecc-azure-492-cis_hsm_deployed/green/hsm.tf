data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_managed_hardware_security_module" "this" {
  name                       = "kv${var.prefix}green21${random_integer.this.result}"
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "Standard_B1"
  purge_protection_enabled   = false
  admin_object_ids           = [data.azurerm_client_config.current.object_id]

  tags = var.tags
}
