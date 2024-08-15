resource "azurerm_virtual_network" "this" {
  name                = module.naming.resource_prefix.vnet
  address_space       = ["10.0.0.0/16"]
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  
  tags                 = module.naming.default_tags
}

resource "azurerm_subnet" "this" {
  name                 = module.naming.resource_prefix.subnet
  resource_group_name  = data.terraform_remote_state.common.outputs.resource_group
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "this" {
  name                = module.naming.resource_prefix.publicip
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = module.naming.default_tags
}

resource "azurerm_application_gateway" "this" {
  name                = module.naming.resource_prefix.appgw
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "autotestci_gtw_ip_conf_red"
    subnet_id = azurerm_subnet.this.id
  }

  frontend_port {
    name = "autotestci_front_port_red"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "autotestci_front_ip_conf_red"
    public_ip_address_id = azurerm_public_ip.this.id
  }

  backend_address_pool {
    name = "autotestci_back_adr_pool_red"
  }

  backend_http_settings {
    name                  = "autotestci_back_http_set_red"
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "autotestci_http_listener_red"
    frontend_ip_configuration_name = "autotestci_front_ip_conf_red"
    frontend_port_name             = "autotestci_front_port_red"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "autotestci_routrule_red"
    rule_type                  = "Basic"
    http_listener_name         = "autotestci_http_listener_red"
    backend_address_pool_name  = "autotestci_back_adr_pool_red"
    backend_http_settings_name = "autotestci_back_http_set_red"
    priority                   = 10
  }

  waf_configuration {
    enabled          = false
    firewall_mode    = "Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = "2.2.9"

  }

  tags = module.naming.default_tags
}