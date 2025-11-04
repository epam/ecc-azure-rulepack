data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "this" {
  name                       = "${module.naming.resource_prefix.keyvault}kv${random_integer.this.result}"
  location                   = data.terraform_remote_state.common.outputs.location
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = true
  rbac_authorization_enabled = true

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "Create", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify", "GetRotationPolicy", "SetRotationPolicy"
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Purge",
    ]

  }

  tags = module.naming.default_tags
}

resource "azurerm_key_vault" "this1" {
  name                       = "${module.naming.resource_prefix.keyvault}kv1${random_integer.this.result}"
  location                   = data.terraform_remote_state.common.outputs.location
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"

  network_acls {
    bypass         = "None"
    default_action = "Deny"
  }

  tags = module.naming.default_tags
}

resource "azurerm_key_vault_key" "this" {
  name            = "${module.naming.resource_prefix.keyvaultkey}key${random_integer.this.result}"
  key_vault_id    = azurerm_key_vault.this.id
  key_type        = "RSA"
  key_size        = 2048
  expiration_date = "2025-01-01T12:00:00Z"

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }

    expire_after         = "P90D"
    notify_before_expiry = "P29D"
  }

  tags = module.naming.default_tags
}

resource "azurerm_key_vault_secret" "this" {
  name            = "${module.naming.resource_prefix.keyvaultsecret}sec${random_integer.this.result}"
  value           = "123456"
  key_vault_id    = azurerm_key_vault.this.id
  expiration_date = "2025-01-01T12:00:00Z"
  content_type    = "plainText"
}