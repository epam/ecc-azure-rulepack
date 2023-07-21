resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-green"
  location = var.location

  tags = var.tags
}

resource "azurerm_frontdoor" "this" {
  name                = "${var.prefix}frontdoorgreen"
  resource_group_name = azurerm_resource_group.this.name

  routing_rule {
    name               = "${var.prefix}fdroutingrle"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["${var.prefix}fdendpoint"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "${var.prefix}backendpoolgreen"
    }
  }

  backend_pool_load_balancing {
    name = "${var.prefix}bplbgreen"
  }

  backend_pool_health_probe {
    name = "${var.prefix}healthprobegreen"
  }

  backend_pool {
    name = "${var.prefix}backendpoolgreen"
    backend {
      host_header = "www.bing.com"
      address     = "www.bing.com"
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "${var.prefix}bplbgreen"
    health_probe_name   = "${var.prefix}healthprobegreen"
  }


  frontend_endpoint {
    name                                    = "${var.prefix}fdendpoint"
    host_name                               = "${var.prefix}frontdoorgreen.azurefd.net"
    web_application_firewall_policy_link_id = azurerm_frontdoor_firewall_policy.this.id
  }

  depends_on = [
    azurerm_frontdoor_firewall_policy.this
  ]

  tags = var.tags
}