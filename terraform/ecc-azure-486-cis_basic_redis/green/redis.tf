resource "azurerm_redis_cache" "this" {
  name                = "${var.prefix}redisgreen"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  capacity            = 1
  family              = "C"
  sku_name            = "Standard"
  minimum_tls_version = "1.2"

  redis_configuration {}

  tags = var.tags
}

