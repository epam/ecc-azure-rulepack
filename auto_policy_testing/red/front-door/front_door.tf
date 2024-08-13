data "azurerm_client_config" "current" {}

resource "azurerm_frontdoor" "this" {
  name                = "redcifdendpoint"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  routing_rule {
    name               = "redcifdroutingrle"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["redcifdendpoint"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "redcibackendpoolred"
    }
  }

  backend_pool_load_balancing {
    name = "redcibplbred"
  }

  backend_pool_health_probe {
    name = "redcihealthprobered"
  }

  backend_pool {
    name = "redcibackendpoolred"
    backend {
      host_header = "www.bing.com"
      address     = "www.bing.com"
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "redcibplbred"
    health_probe_name   = "redcihealthprobered"
  }

  frontend_endpoint {
    name      = "redcifdendpoint"
    host_name = "redcifdendpoint.azurefd.net"
  }

  depends_on = [
    azurerm_frontdoor_firewall_policy.this,
    random_integer.this
  ]

  tags = module.naming.default_tags
}