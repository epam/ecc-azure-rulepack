resource "azurerm_frontdoor" "this" {
  name                = "frontdoorgreen"
  resource_group_name = azurerm_resource_group.this.name

  routing_rule {
    name               = "greenRoutingRule1"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["frontdoorgreen"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "greenBackendBing"
    }
  }

  backend_pool_load_balancing {
    name = "greenLoadBalancingSettings1"
  }

  backend_pool_health_probe {
    name = "greenHealthProbeSetting1"
  }

  backend_pool {
    name = "greenBackendBing"
    backend {
      host_header = "www.bing.com"
      address     = "www.bing.com"
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "greenLoadBalancingSettings1"
    health_probe_name   = "greenHealthProbeSetting1"
  }

  frontend_endpoint {
    name      = "frontdoorgreen"
    host_name = "frontdoorgreen.azurefd.net"
    web_application_firewall_policy_link_id = azurerm_frontdoor_firewall_policy.this.id
  }

  depends_on = [ azurerm_frontdoor_firewall_policy.this ]

}

resource "azurerm_frontdoor_firewall_policy" "this" {
  name                              = "greenfdwafpolicy"
  resource_group_name               = azurerm_resource_group.this.name
  enabled                           = true
  mode                              = "Prevention"
  redirect_url                      = "https://www.contoso.com"
  custom_block_response_status_code = 403
  custom_block_response_body        = "PGh0bWw+CjxoZWFkZXI+PHRpdGxlPkhlbGxvPC90aXRsZT48L2hlYWRlcj4KPGJvZHk+CkhlbGxvIHdvcmxkCjwvYm9keT4KPC9odG1sPg=="

  managed_rule {
    type    = "DefaultRuleSet"
    version = "1.0"

    exclusion {
      match_variable = "QueryStringArgNames"
      operator       = "Equals"
      selector       = "not_suspicious"
    }

    override {
      rule_group_name = "JAVA"

      rule {
        rule_id = "944240"
        enabled = true
        action  = "Block"
      }
    }

  }

  managed_rule {
    type    = "Microsoft_BotManagerRuleSet"
    version = "1.0"
  }
}