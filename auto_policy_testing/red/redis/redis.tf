data "azurerm_client_config" "current" {}

resource "azurerm_redis_cache" "this" {
  name                = module.naming.resource_prefix.redis
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  capacity            = 1
  family              = "C"
  sku_name            = "Premium"
  enable_non_ssl_port = true
  minimum_tls_version = "1.2"

  redis_configuration {
  }

  tags = module.naming.default_tags
}

resource "azurerm_redis_firewall_rule" "this" {
  name                = "someIPrange"
  redis_cache_name    = azurerm_redis_cache.this.name
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  start_ip            = "0.0.0.0"
  end_ip              = "0.0.0.0"
}
