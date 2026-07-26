data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                       = "kv${var.prefix}green${random_integer.this.result}"
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  public_network_access_enabled = false
  
  tags = var.tags
}
