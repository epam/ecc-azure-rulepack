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

resource "azurerm_resource_group" "this" {
  name     = module.naming.resource_prefix.resourcegroup
  location = data.terraform_remote_state.common.outputs.location

  tags = module.naming.default_tags
}

resource "azurerm_frontdoor" "this1" {
  name                = "redcifdendpoint1"
  resource_group_name = azurerm_resource_group.this.name

  routing_rule {
    name               = "redcifdroutingrle1"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["redcifdendpoint1"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "redcibackendpoolred1"
    }
  }

  backend_pool_load_balancing {
    name = "redcibplbred1"
  }

  backend_pool_health_probe {
    name = "redcihealthprobered1"
  }

  backend_pool {
    name = "redcibackendpoolred1"
    backend {
      host_header = "www.bing.com"
      address     = "www.bing.com"
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "redcibplbred1"
    health_probe_name   = "redcihealthprobered1"
  }

  frontend_endpoint {
    name      = "redcifdendpoint1"
    host_name = "redcifdendpoint1.azurefd.net"
  }

  depends_on = [
    azurerm_frontdoor_firewall_policy.this,
    random_integer.this
  ]

  tags = module.naming.default_tags
}