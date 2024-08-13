resource "azurerm_frontdoor" "this" {
  name                = "${random_integer.this.result}frontdoorred"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  routing_rule {
    name               = "autotestcifdroutingrlered"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["autotestcifdendpointred"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "autotestcibackendpoolred"
    }
  }

  backend_pool_load_balancing {
    name = "autotestcibplbred"
  }

  backend_pool_health_probe {
    name = "autotestcihealthprobered"
  }

  backend_pool {
    name = "autotestcibackendpoolred"
    backend {
      host_header = "www.bing.com"
      address     = "www.bing.com"
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "autotestcibplbred"
    health_probe_name   = "autotestcihealthprobered"
  }


  frontend_endpoint {
    name                                    = "autotestcifdendpointred"
    host_name                               = "autotestcifrontdoorred.azurefd.net"
    web_application_firewall_policy_link_id = azurerm_frontdoor_firewall_policy.this.id
  }

  depends_on = [
    azurerm_frontdoor_firewall_policy.this,
    random_integer.this
  ]

  tags = module.naming.default_tags
}