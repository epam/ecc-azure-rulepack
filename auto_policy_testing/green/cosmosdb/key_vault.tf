data "azurerm_client_config" "current" {}

data "azuread_service_principal" "cosmosdb" {
  display_name = "Azure Cosmos DB"
}

resource "azurerm_key_vault" "this" {
  name                       = "${module.naming.resource_prefix.keyvault}kv${random_integer.this.result}"
  location                   = data.terraform_remote_state.common.outputs.location
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7
  purge_protection_enabled   = false

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

  tags = module.naming.default_tags
}


resource "azurerm_key_vault_access_policy" "cosmosdb" {
  key_vault_id = azurerm_key_vault.this.id
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_service_principal.cosmosdb.id

  key_permissions    = ["Get", "UnwrapKey", "WrapKey"]
  secret_permissions = ["Get"]
}