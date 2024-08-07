output "redis" {
  value = {
    redis = azurerm_redis_cache.this.id
  }
}