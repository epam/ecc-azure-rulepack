resource "azurerm_frontdoor" "this" {
  name                = "${var.prefix}frontdoorred"
  resource_group_name = azurerm_resource_group.this.name

  routing_rule {
    name               = "${var.prefix}fdroutingrle"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["${var.prefix}fdendpoint"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "${var.prefix}backendpoolred"
    }
  }

  backend_pool_load_balancing {
    name = "${var.prefix}bplbred"
  }

  backend_pool_health_probe {
    name = "${var.prefix}healthprobered"
  }

  backend_pool {
    name = "${var.prefix}backendpoolred"
    backend {
      host_header = "www.bing.com"
      address     = "www.bing.com"
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "${var.prefix}bplbred"
    health_probe_name   = "${var.prefix}healthprobered"
  }

  frontend_endpoint {
    name      = "${var.prefix}fdendpoint"
    host_name = "${var.prefix}frontdoorred.azurefd.net"
  }

  tags = var.tags
}