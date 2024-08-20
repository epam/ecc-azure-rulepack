resource "azurerm_virtual_network" "this2" {
  name                = "${module.naming.resource_prefix.vnet}-2"
  address_space       = ["10.0.0.0/16"]
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  
  tags                 = module.naming.default_tags
}

resource "azurerm_subnet" "this2" {
  name                 = "${module.naming.resource_prefix.subnet}-2"
  resource_group_name  = data.terraform_remote_state.common.outputs.resource_group
  virtual_network_name = azurerm_virtual_network.this2.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "this2" {
  name                = "${module.naming.resource_prefix.publicip}-2"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = module.naming.default_tags
}

resource "azurerm_application_gateway" "this2" {
  name                = "${module.naming.resource_prefix.appgw}-2"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "autotestci_gtw_ip_conf_red2"
    subnet_id = azurerm_subnet.this2.id
  }

  frontend_port {
    name = "autotestci_front_port_red2"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "autotestci_front_ip_conf_red2"
    public_ip_address_id = azurerm_public_ip.this2.id
  }

  backend_address_pool {
    name = "autotestci_back_adr_pool_red2"
  }

  backend_http_settings {
    name                  = "autotestci_back_http_set_red2"
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "autotestci_http_listener_red2"
    frontend_ip_configuration_name = "autotestci_front_ip_conf_red2"
    frontend_port_name             = "autotestci_front_port_red2"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "autotestci_routrule_red2"
    rule_type                  = "Basic"
    http_listener_name         = "autotestci_http_listener_red2"
    backend_address_pool_name  = "autotestci_back_adr_pool_red2"
    backend_http_settings_name = "autotestci_back_http_set_red2"
    priority                   = 10
  }

  waf_configuration {
    enabled          = true
    firewall_mode    = "Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = "3.0"
    disabled_rule_group {
    rule_group_name = "Known-CVEs"
    }
  }

  tags = module.naming.default_tags
}