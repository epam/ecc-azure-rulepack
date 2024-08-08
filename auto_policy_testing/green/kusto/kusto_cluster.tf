data "azurerm_client_config" "current" {}

resource "azurerm_kusto_cluster" "this" {
  name                = module.naming.resource_prefix.kusto
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  sku {
    name     = "Dev(No SLA)_Standard_D11_v2"
    capacity = 1
  }

  identity {
    type = "SystemAssigned"
  }

  double_encryption_enabled = true
  disk_encryption_enabled = true

  tags = module.naming.default_tags
}

resource "azurerm_kusto_cluster_customer_managed_key" "this" {
  cluster_id   = azurerm_kusto_cluster.this.id
  key_vault_id = data.terraform_remote_state.common.outputs.key_vault_id
  key_name     = data.terraform_remote_state.common.outputs.key_name
  key_version  = data.terraform_remote_state.common.outputs.key_version
}