resource "azurerm_key_vault" "this" {
  name                     = "kv${var.prefix}green${random_integer.this.result}"
  location                 = azurerm_resource_group.this.location
  resource_group_name      = azurerm_resource_group.this.name
  tenant_id                = data.azurerm_client_config.current.tenant_id
  sku_name                 = "premium"
  purge_protection_enabled = true

  tags = var.tags
}

resource "azurerm_key_vault_access_policy" "this" {
    key_vault_id = azurerm_key_vault.this.id
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id
    key_permissions = [
      "Create",
      "Get",
      "Purge",
      "Delete",
      "GetRotationPolicy",
      "SetRotationPolicy"
    ]
}

resource "azurerm_key_vault_key" "this" {
  name         = "ml1wrkspkey"
  key_vault_id = azurerm_key_vault.this.id
  key_type     = "RSA"
  key_size     = 3072

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  depends_on = [
    azurerm_key_vault.this, azurerm_key_vault_access_policy.this
  ]
}