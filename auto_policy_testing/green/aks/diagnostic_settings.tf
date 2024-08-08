resource "azurerm_monitor_diagnostic_setting" "this" {
  name               = module.naming.resource_prefix.diagnosticsetting
  target_resource_id = azurerm_kubernetes_cluster.this.id
  storage_account_id = data.terraform_remote_state.common.outputs.storage_id

  enabled_log {
    category = "kube-apiserver"
  }
}