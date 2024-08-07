output "redis" {
  value = {
    redis = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.terraform_remote_state.common.outputs.resource_group}/providers/Microsoft.Cache/Redis/${azurerm_redis_cache.this.name}"
  }
}