resource "azurerm_frontdoor" "this" {
  name                = "${random_integer.this.result}frontdoorgreen"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  routing_rule {
    name               = "greencifdroutingrle"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["greencifdendpoint"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "greencibackendpoolgreen"
    }
  }

  backend_pool_load_balancing {
    name = "greencibplbgreen"
  }

  backend_pool_health_probe {
    name = "greencihealthprobegreen"
  }

  backend_pool {
    name = "greencibackendpoolgreen"
    backend {
      host_header = "www.bing.com"
      address     = "www.bing.com"
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "greencibplbgreen"
    health_probe_name   = "greencihealthprobegreen"
  }


  frontend_endpoint {
    name                                    = "greencifdendpoint"
    host_name                               = "greencifrontdoorgreen.azurefd.net"
    web_application_firewall_policy_link_id = azurerm_frontdoor_firewall_policy.this.id
  }

  depends_on = [
    azurerm_frontdoor_firewall_policy.this,
    random_integer.this
  ]

  tags = module.naming.default_tags
}