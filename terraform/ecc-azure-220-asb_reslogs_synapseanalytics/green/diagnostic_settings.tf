resource "azurerm_storage_account" "thisdiag" {
  name                     = "diag${var.prefix}sagreen"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name               = "${var.prefix}settinggreen"
  target_resource_id = azurerm_synapse_workspace.this.id
  storage_account_id = azurerm_storage_account.thisdiag.id

  enabled_log {
    category = "SynapseRBACOperations"
  }
}
