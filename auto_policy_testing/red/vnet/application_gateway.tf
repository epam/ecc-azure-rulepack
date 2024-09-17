resource "azurerm_resource_group" "this" {
  name     = "${random_string.this.result}-vnet-rg-red"
  location = "eastus"

  tags = module.naming.default_tags
}

resource "azurerm_virtual_network" "this1" {
  name                = "${module.naming.resource_prefix.vnet}1"
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
  resource_group_name = azurerm_resource_group.this.name
  
  tags = module.naming.default_tags
}

resource "azurerm_subnet" "this1" {
  name                  = "${module.naming.resource_prefix.subnet}1"
  resource_group_name   = azurerm_resource_group.this.name
  virtual_network_name  = azurerm_virtual_network.this1.name
  address_prefixes      = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "this" {
  name                = "${random_string.this.result}_pip_red"
  location                        = "eastus"
  resource_group_name             = azurerm_resource_group.this.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = module.naming.default_tags
}

resource "azurerm_application_gateway" "this" {
  name                = "${random_string.this.result}_app_gateway_red"
  location                        = "eastus"
  resource_group_name             = azurerm_resource_group.this.name

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }
  gateway_ip_configuration {
    name      = "${random_string.this.result}_gtw_ip_conf_red"
    subnet_id = azurerm_subnet.this1.id
  }

  frontend_port {
    name = "${random_string.this.result}_front_port_red"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "${random_string.this.result}_front_ip_conf_red"
    public_ip_address_id = azurerm_public_ip.this.id
  }

  backend_address_pool {
    name = "${random_string.this.result}_back_adr_pool_red"
  }

  backend_http_settings {
    name                  = "${random_string.this.result}_back_http_set_red"
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "${random_string.this.result}_http_listener_red"
    frontend_ip_configuration_name = "${random_string.this.result}_front_ip_conf_red"
    frontend_port_name             = "${random_string.this.result}_front_port_red"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${random_string.this.result}_routrule_red"
    priority                   = 10
    rule_type                  = "Basic"
    http_listener_name         = "${random_string.this.result}_http_listener_red"
    backend_address_pool_name  = "${random_string.this.result}_back_adr_pool_red"
    backend_http_settings_name = "${random_string.this.result}_back_http_set_red"
  }

  waf_configuration {
    enabled          = true
    firewall_mode    = "Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = "3.0"

  }

  tags = module.naming.default_tags
}