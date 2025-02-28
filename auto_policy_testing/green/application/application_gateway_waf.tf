resource "azurerm_public_ip" "this1" {
  name                = "${module.naming.resource_prefix.publicip}-1"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = module.naming.default_tags
}

resource "azurerm_application_gateway" "this1" {
  name                = "${module.naming.resource_prefix.appgw}-1"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "autotestci_gtw_ip_conf_green"
    subnet_id = azurerm_subnet.this.id
  }

  frontend_port {
    name = "autotestci_front_port_green"
    port = 443
  }

  frontend_ip_configuration {
    name                 = "autotestci_front_ip_conf_green"
    public_ip_address_id = azurerm_public_ip.this.id
  }

  backend_address_pool {
    name = "autotestci_back_adr_pool_green"
  }

  backend_http_settings {
    name                  = "autotestci_back_http_set_green"
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 60
  }

  http_listener {
    name                           = "autotestci_http_listener_green"
    frontend_ip_configuration_name = "autotestci_front_ip_conf_green"
    frontend_port_name             = "autotestci_front_port_green"
    protocol                       = "Https"
  }

  request_routing_rule {
    name                       = "autotestci_routrule_green"
    rule_type                  = "Basic"
    http_listener_name         = "autotestci_http_listener_green"
    backend_address_pool_name  = "autotestci_back_adr_pool_green"
    backend_http_settings_name = "autotestci_back_http_set_green"
    priority                   = 10
  }

  firewall_policy_id = azurerm_web_application_firewall_policy.this.id
}

resource "azurerm_web_application_firewall_policy" "this" {
  name                = module.naming.resource_prefix.waf
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  custom_rules {
    name      = "Rule1"
    priority  = 1
    rule_type = "MatchRule"

    match_conditions {
      match_variables {
        variable_name = "RemoteAddr"
      }

      operator           = "IPMatch"
      negation_condition = false
      match_values       = ["192.168.1.0/24", "10.0.0.0/24"]
    }

    action = "Block"
  }

  policy_settings {
    enabled                     = true
    mode                        = "Prevention"
    request_body_check          = true
    file_upload_limit_in_mb     = 100
    max_request_body_size_in_kb = 128
  }

  managed_rules {
    exclusion {
      match_variable          = "RequestHeaderNames"
      selector                = "x-company-secret-header"
      selector_match_operator = "Equals"
    }
    exclusion {
      match_variable          = "RequestCookieNames"
      selector                = "too-tasty"
      selector_match_operator = "EndsWith"
    }

    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
      rule_group_override {
        rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
        rule {
          id      = "920300"
          enabled = true
          action  = "Log"
        }

        rule {
          id      = "920440"
          enabled = true
          action  = "Block"
        }
      }
    }
  }
}