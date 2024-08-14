output "batch" {
  value = {
    batch = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/green-infrastructure-ci/providers/Microsoft.Batch/batchAccounts/${azurerm_batch_account.this.id}"
  }
}