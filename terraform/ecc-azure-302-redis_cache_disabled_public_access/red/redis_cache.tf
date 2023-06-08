resource "azurerm_redis_cache" "this" {
  name                = "${var.prefix}-redis-red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  capacity            = 1
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = false

  redis_configuration {}

  tags = var.tags
}