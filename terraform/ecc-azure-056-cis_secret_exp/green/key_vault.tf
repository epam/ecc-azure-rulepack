resource "azurerm_key_vault" "this" {
  name                = "kv${var.prefix}green${random_integer.this.result}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Purge",
    ]
  }

  tags = var.tags

}

resource "azurerm_key_vault_secret" "this" {
  name            = "secret${var.prefix}green"
  value           = "123456"
  key_vault_id    = azurerm_key_vault.this.id
  expiration_date = "2023-01-01T12:00:00Z"
}

