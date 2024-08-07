output "stream" {
  value = {
    stream-job = azurerm_stream_analytics_job.this.id
  }
}