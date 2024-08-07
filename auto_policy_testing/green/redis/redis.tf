resource "azurerm_redis_cache" "this" {
  name                = module.naming.resource_prefix.redis
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  capacity            = 1
  family              = "P"
  sku_name            = "Premium"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  subnet_id = data.terraform_remote_state.common.outputs.subnet_id

  redis_configuration {
  }

  public_network_access_enabled = false

  tags = module.naming.default_tags
}

resource "azurerm_redis_firewall_rule" "this" {
  name                = "someIPrange"
  redis_cache_name    = azurerm_redis_cache.this.name
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  start_ip            = "1.2.3.4"
  end_ip              = "2.3.4.5"
}

