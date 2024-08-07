resource "azurerm_redis_cache" "this" {
  name                = module.naming.resource_prefix.redis
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  capacity            = 1
  family              = "P"
  sku_name            = "Premium"
  enable_non_ssl_port = true
  minimum_tls_version = "1.2"

  redis_configuration {
  }

  public_network_access_enabled = true

  tags = module.naming.default_tags
}

