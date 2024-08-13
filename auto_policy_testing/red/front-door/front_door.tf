resource "azurerm_frontdoor" "this" {
  name                = "${random_integer.this.result}frontdoorred"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  routing_rule {
    name               = "${random_integer.this.result}fdroutingrle"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["${random_integer.this.result}fdendpoint"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "${random_integer.this.result}backendpoolred"
    }
  }

  backend_pool_load_balancing {
    name = "${random_integer.this.result}bplbred"
  }

  backend_pool_health_probe {
    name = "${random_integer.this.result}healthprobered"
  }

  backend_pool {
    name = "${random_integer.this.result}backendpoolred"
    backend {
      host_header = "www.bing.com"
      address     = "www.bing.com"
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "${random_integer.this.result}bplbred"
    health_probe_name   = "${random_integer.this.result}healthprobered"
  }


  frontend_endpoint {
    name                                    = "${random_integer.this.result}fdendpoint"
    host_name                               = "${random_integer.this.result}frontdoorred.azurefd.net"
    web_application_firewall_policy_link_id = azurerm_frontdoor_firewall_policy.this.id
  }

  depends_on = [
    azurerm_frontdoor_firewall_policy.this,
    random_integer.this
  ]

  tags = module.naming.default_tags
}