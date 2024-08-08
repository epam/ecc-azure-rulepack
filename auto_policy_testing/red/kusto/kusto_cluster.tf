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

  double_encryption_enabled = false
  disk_encryption_enabled = false

  tags = module.naming.default_tags
}