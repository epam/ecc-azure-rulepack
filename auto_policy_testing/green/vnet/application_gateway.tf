resource "azurerm_virtual_network" "this1" {
  name                = "${module.naming.resource_prefix.vnet}1"
  address_space       = ["10.0.0.0/16"]
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  
  tags = module.naming.default_tags
}

resource "azurerm_subnet" "this1" {
  name                  = "${module.naming.resource_prefix.subnet}1"
  resource_group_name   = data.terraform_remote_state.common.outputs.resource_group
  virtual_network_name  = azurerm_virtual_network.this1.name
  address_prefixes      = ["10.0.2.0/24"]
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
    name      = "autotestci_vnet_ip_conf_green"
    subnet_id = azurerm_subnet.this1.id
  }

  frontend_port {
    name = "autotestci_vnet_front_port_green"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "autotestci_vnet_front_ip_conf_green"
    public_ip_address_id = azurerm_public_ip.this.id
  }

  backend_address_pool {
    name = "autotestci_vnet_back_adr_pool_green"
  }

  backend_http_settings {
    name                  = "autotestci_vnet_back_http_set_green"
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "autotestci_vnet_http_listener_green"
    frontend_ip_configuration_name = "autotestci_vnet_front_ip_conf_green"
    frontend_port_name             = "autotestci_vnet_front_port_green"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "autotestci_vnet_routrule_green"
    rule_type                  = "Basic"
    http_listener_name         = "autotestci_vnet_http_listener_green"
    backend_address_pool_name  = "autotestci_vnet_back_adr_pool_green"
    backend_http_settings_name = "autotestci_vnet_back_http_set_green"
    priority                   = 10
  }

  waf_configuration {
    enabled          = true
    firewall_mode    = "Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = "3.0"

  }

  tags = module.naming.default_tags
}

resource "azurerm_network_ddos_protection_plan" "this" {
  name                = "autotestci_vnet-ddos_prot_plan"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  tags                = module.naming.default_tags

  lifecycle {
    create_before_destroy = true
  }
}