resource "azurerm_synapse_workspace" "this" {
  name                                 = "workspace${var.prefix}-red"
  resource_group_name                  = azurerm_resource_group.this.name
  location                             = azurerm_resource_group.this.location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.this.id
  sql_administrator_login              = random_string.this.result
  sql_administrator_login_password     = random_password.this.result
  managed_virtual_network_enabled      = true
  data_exfiltration_protection_enabled = false

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}