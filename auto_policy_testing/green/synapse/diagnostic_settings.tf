resource "azurerm_monitor_diagnostic_setting" "this" {
  name               = "synapsesettinggreen${random_integer.this.result}"
  target_resource_id = azurerm_synapse_workspace.this.id
  storage_account_id = data.terraform_remote_state.common.outputs.storage_id

  enabled_log {
    category = "SynapseRBACOperations"
  }
}
