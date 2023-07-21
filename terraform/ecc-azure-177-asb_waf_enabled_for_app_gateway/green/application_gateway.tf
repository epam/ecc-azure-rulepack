resource "azurerm_virtual_network" "this" {
  name                = "${var.prefix}_vnet_green"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  address_space       = ["10.0.0.0/16"]

  tags = var.tags
}

resource "azurerm_subnet" "this" {
  name                 = "appgtwgreen"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "this" {
  name                = "${var.prefix}_pip_green"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = var.tags
}

resource "azurerm_application_gateway" "this" {
  name                = "${var.prefix}_app_gateway_green"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  sku {
    name     = "WAF_v2"
    tier     = "WAF_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "${var.prefix}_gtw_ip_conf_green"
    subnet_id = azurerm_subnet.this.id
  }

  frontend_port {
    name = "${var.prefix}_front_port_green"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "${var.prefix}_front_ip_conf_green"
    public_ip_address_id = azurerm_public_ip.this.id
  }

  backend_address_pool {
    name = "${var.prefix}_back_adr_pool_green"
  }

  backend_http_settings {
    name                  = "${var.prefix}_back_http_set_green"
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "${var.prefix}_http_listener_green"
    frontend_ip_configuration_name = "${var.prefix}_front_ip_conf_green"
    frontend_port_name             = "${var.prefix}_front_port_green"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${var.prefix}_routrule_green"
    rule_type                  = "Basic"
    http_listener_name         = "${var.prefix}_http_listener_green"
    backend_address_pool_name  = "${var.prefix}_back_adr_pool_green"
    backend_http_settings_name = "${var.prefix}_back_http_set_green"
  }

  waf_configuration {
    enabled          = true
    firewall_mode    = "Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = "3.0"

  }

  tags = var.tags
}