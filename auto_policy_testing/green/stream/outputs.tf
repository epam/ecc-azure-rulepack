output "stream" {
  value = {
    stream-job = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.terraform_remote_state.common.outputs.resource_group}/providers/Microsoft.StreamAnalytics/streamingjobs/${azurerm_stream_analytics_job.this.name}"
  }
}