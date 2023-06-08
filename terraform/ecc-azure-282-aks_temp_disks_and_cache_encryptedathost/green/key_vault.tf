data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                        = "kv${var.prefix}green${random_integer.this.result}"
  location                    = azurerm_resource_group.this.location
  resource_group_name         = azurerm_resource_group.this.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "premium"
  enabled_for_disk_encryption = true
  purge_protection_enabled    = true
}

resource "azurerm_key_vault_key" "this" {
  name         = "key-${var.prefix}-green"
  key_vault_id = azurerm_key_vault.this.id
  key_type     = "RSA"
  key_size     = 2048

  depends_on = [
    azurerm_key_vault_access_policy.current_user_access_policy
  ]

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}

resource "azurerm_key_vault_access_policy" "k8s-access-policy" {
  key_vault_id = azurerm_key_vault.this.id

  tenant_id = azurerm_kubernetes_cluster.this.identity.0.tenant_id
  object_id = azurerm_kubernetes_cluster.this.identity.0.principal_id

  key_permissions = [
    "Get",
    "WrapKey",
    "UnwrapKey"
  ]
}

resource "azurerm_key_vault_access_policy" "current_user_access_policy" {
  key_vault_id = azurerm_key_vault.this.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get",
    "Create",
    "Delete"
  ]
}