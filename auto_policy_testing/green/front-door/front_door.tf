resource "azurerm_frontdoor" "this" {
  name                = "${random_integer.this.result}frontdoorgreen"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  routing_rule {
    name               = "autotestcifdroutingrlegreen"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["autotestcifdendpointgreen"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "autotestcibackendpoolgreen"
    }
  }

  backend_pool_load_balancing {
    name = "autotestcibplbgreen"
  }

  backend_pool_health_probe {
    name = "autotestcihealthprobegreen"
  }

  backend_pool {
    name = "autotestcibackendpoolgreen"
    backend {
      host_header = "www.bing.com"
      address     = "www.bing.com"
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "autotestcibplbgreen"
    health_probe_name   = "autotestcihealthprobegreen"
  }


  frontend_endpoint {
    name                                    = "autotestcifdendpointgreen"
    host_name                               = "autotestcifrontdoorgreen.azurefd.net"
    web_application_firewall_policy_link_id = azurerm_frontdoor_firewall_policy.this.id
  }

  depends_on = [
    azurerm_frontdoor_firewall_policy.this,
    random_integer.this
  ]

  tags = module.naming.default_tags
}