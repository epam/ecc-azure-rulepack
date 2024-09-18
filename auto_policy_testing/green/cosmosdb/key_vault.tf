data "azurerm_client_config" "current" {}

data "azuread_service_principal" "cosmosdb" {
  display_name = "Azure Cosmos DB"
}

resource "azurerm_key_vault_access_policy" "cosmosdb" {
  key_vault_id = data.terraform_remote_state.common.outputs.key_vault_id
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azuread_service_principal.cosmosdb.id

  key_permissions    = ["Get", "UnwrapKey", "WrapKey"]
  secret_permissions = ["Get"]
}