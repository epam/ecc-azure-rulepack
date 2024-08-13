resource "azurerm_frontdoor" "this" {
  name                = "${random_integer.this.result}frontdoorgreen"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  routing_rule {
    name               = "${random_integer.this.result}fdroutingrle"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["${random_integer.this.result}fdendpoint"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "${random_integer.this.result}backendpoolgreen"
    }
  }

  backend_pool_load_balancing {
    name = "${random_integer.this.result}bplbgreen"
  }

  backend_pool_health_probe {
    name = "${random_integer.this.result}healthprobegreen"
  }

  backend_pool {
    name = "${random_integer.this.result}backendpoolgreen"
    backend {
      host_header = "www.bing.com"
      address     = "www.bing.com"
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "${random_integer.this.result}bplbgreen"
    health_probe_name   = "${random_integer.this.result}healthprobegreen"
  }


  frontend_endpoint {
    name                                    = "${random_integer.this.result}fdendpoint"
    host_name                               = "${random_integer.this.result}frontdoorgreen.azurefd.net"
    web_application_firewall_policy_link_id = azurerm_frontdoor_firewall_policy.this.id
  }

  depends_on = [
    azurerm_frontdoor_firewall_policy.this,
    random_integer.this
  ]

  tags = module.naming.default_tags
}