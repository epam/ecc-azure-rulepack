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
    name      = "autotestci_gtw_ip_conf_green"
    subnet_id = azurerm_subnet.this.id
  }

  frontend_port {
    name = "autotestci_front_port_green"
    port = 80
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
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  ssl_certificate {
    name = "green-appgw-cert"
    key_vault_secret_id = azurerm_key_vault_certificate.this.secret_id
  }

  http_listener {
    name                           = "autotestci_http_listener_green"
    frontend_ip_configuration_name = "autotestci_front_ip_conf_green"
    frontend_port_name             = "autotestci_front_port_green"
    protocol                       = "Https"
    ssl_certificate_name           = "green-appgw-cert"
  }

  request_routing_rule {
    name                       = "autotestci_routrule_green"
    rule_type                  = "Basic"
    http_listener_name         = "autotestci_http_listener_green"
    backend_address_pool_name  = "autotestci_back_adr_pool_green"
    backend_http_settings_name = "autotestci_back_http_set_green"
    priority                   = 10
  }

  ssl_policy {
    policy_type = "Custom"
    cipher_suites = ["TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256",
      "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384",
      "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA",
      "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA",
      "TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256",
      "TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384",
      "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
      "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
      "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA",
      "TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA",
      "TLS_RSA_WITH_AES_256_GCM_SHA384",
      "TLS_RSA_WITH_AES_128_GCM_SHA256",
      "TLS_RSA_WITH_AES_256_CBC_SHA256",
      "TLS_RSA_WITH_AES_128_CBC_SHA256",
      "TLS_RSA_WITH_AES_256_CBC_SHA",
    "TLS_RSA_WITH_AES_128_CBC_SHA"]
    min_protocol_version = "TLSv1_2"
  }

  waf_configuration {
    enabled          = true
    firewall_mode    = "Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = "3.0"

  }

  identity {
    type = "SystemAssigned"
  }

  tags = module.naming.default_tags
}