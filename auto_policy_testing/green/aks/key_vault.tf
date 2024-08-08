data "azurerm_client_config" "current" {}

resource "azurerm_key_vault_access_policy" "k8s-access-policy" {
  key_vault_id = data.terraform_remote_state.common.outputs.key_vault_id

  tenant_id = azurerm_kubernetes_cluster.this.identity[0].tenant_id
  object_id = azurerm_kubernetes_cluster.this.identity[0].principal_id

  key_permissions = [
    "Get",
    "WrapKey",
    "UnwrapKey"
  ]
}

resource "azurerm_key_vault_access_policy" "encryptionset" {
  key_vault_id = data.terraform_remote_state.common.outputs.key_vault_id

  tenant_id = azurerm_disk_encryption_set.this.identity.0.tenant_id
  object_id = azurerm_disk_encryption_set.this.identity.0.principal_id

  key_permissions = [
    "Get",
    "WrapKey",
    "UnwrapKey"
  ]
}

resource "azurerm_disk_encryption_set" "this" {
  name                = module.naming.resource_prefix.encryptionset
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  key_vault_key_id    = data.terraform_remote_state.common.outputs.key_id

  identity {
    type = "SystemAssigned"
  }

  tags = module.naming.default_tags
}

