resource "azurerm_virtual_network" "this1" {
  name                = "${module.naming.resource_prefix.vnet}-1"
  address_space       = ["10.0.0.0/16"]
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  
  tags                 = module.naming.default_tags
}

resource "azurerm_subnet" "this1" {
  name                 = "${module.naming.resource_prefix.subnet}-1"
  resource_group_name  = data.terraform_remote_state.common.outputs.resource_group
  virtual_network_name = azurerm_virtual_network.this1.name
  address_prefixes     = ["10.0.1.0/24"]
}

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
    name      = "autotestci_gtw_ip_conf_red1"
    subnet_id = azurerm_subnet.this1.id
  }

  frontend_port {
    name = "autotestci_front_port_red1"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "autotestci_front_ip_conf_red1"
    public_ip_address_id = azurerm_public_ip.this1.id
  }

  backend_address_pool {
    name = "autotestci_back_adr_pool_red1"
  }

  backend_http_settings {
    name                  = "autotestci_back_http_set_red1"
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "autotestci_http_listener_red1"
    frontend_ip_configuration_name = "autotestci_front_ip_conf_red1"
    frontend_port_name             = "autotestci_front_port_red1"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "autotestci_routrule_red1"
    rule_type                  = "Basic"
    http_listener_name         = "autotestci_http_listener_red1"
    backend_address_pool_name  = "autotestci_back_adr_pool_red1"
    backend_http_settings_name = "autotestci_back_http_set_red1"
    priority                   = 10
  }

  waf_configuration {
    enabled          = true
    firewall_mode    = "Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = "2.2.9"
    disabled_rule_group {
      rule_group_name = "Known-CVEs"
    }
  }

  tags = module.naming.default_tags
}