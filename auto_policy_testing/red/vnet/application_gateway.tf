resource "azurerm_public_ip" "this" {
  name                = "${random_string.this.result}_pip_red"
  location                        = data.terraform_remote_state.common.outputs.location
  resource_group_name             = data.terraform_remote_state.common.outputs.resource_group
  allocation_method   = "Dynamic"

  tags = module.naming.default_tags
}

resource "azurerm_application_gateway" "this" {
  name                = "${random_string.this.result}_app_gateway_red"
  location                        = data.terraform_remote_state.common.outputs.location
  resource_group_name             = data.terraform_remote_state.common.outputs.resource_group

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  gateway_ip_configuration {
    name      = "${random_string.this.result}_gtw_ip_conf_red"
    subnet_id = azurerm_subnet.this.id
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
    rule_type                  = "Basic"
    http_listener_name         = "${random_string.this.result}_http_listener_red"
    backend_address_pool_name  = "${random_string.this.result}_back_adr_pool_red"
    backend_http_settings_name = "${random_string.this.result}_back_http_set_red"
  }

  tags = module.naming.default_tags
}