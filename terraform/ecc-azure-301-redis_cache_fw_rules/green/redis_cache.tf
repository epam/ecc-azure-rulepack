resource "azurerm_redis_cache" "this" {
  name                = "${var.prefix}-redis-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  capacity            = 1
  family              = "P"
  sku_name            = "Premium"
  enable_non_ssl_port = false

  redis_configuration {
  }
}

resource "azurerm_redis_firewall_rule" "this" {
  name                = "someIPrange"
  redis_cache_name    = azurerm_redis_cache.this.name
  resource_group_name = azurerm_resource_group.this.name
  start_ip            = "1.2.3.4"
  end_ip              = "2.3.4.5"
}