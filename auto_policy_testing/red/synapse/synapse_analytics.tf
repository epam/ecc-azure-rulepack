resource "azurerm_storage_data_lake_gen2_filesystem" "this" {
  name               = "data-lake-synapse-red"
  storage_account_id = data.terraform_remote_state.common.outputs.storage_id
}

resource "azurerm_synapse_workspace" "this" {
  name                                 = module.naming.resource_prefix.synapse
  location                             = data.terraform_remote_state.common.outputs.location
  resource_group_name                  = data.terraform_remote_state.common.outputs.resource_group
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.this.id
  sql_administrator_login              = random_string.this.result
  sql_administrator_login_password     = random_password.this.result
  managed_virtual_network_enabled      = false
  data_exfiltration_protection_enabled = false

  identity {
    type = "SystemAssigned"
  }

  tags = module.naming.default_tags
}