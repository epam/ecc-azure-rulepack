resource "azurerm_public_ip" "this" {
  name                = module.naming.resource_prefix.publicip
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  allocation_method   = "Static"

  tags = module.naming.default_tags
}

resource "azurerm_lb" "this" {
  name                = module.naming.resource_prefix.loadbalancer
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "loadbalancer-ci-front-green"
    public_ip_address_id = azurerm_public_ip.this.id
  }

  tags = module.naming.default_tags
}

resource "azurerm_lb_backend_address_pool" "this" {
  loadbalancer_id      = azurerm_lb.this.id
  name                 = "loadbalancer-ci-green-pool"
}

resource "azurerm_lb_backend_address_pool" "additional" {
  loadbalancer_id      = azurerm_lb.this.id
  name                 = "loadbalancer-ci-green-pool-additional"
}

resource "azurerm_lb_probe" "this" {
  loadbalancer_id     = azurerm_lb.this.id
  name                = "loadbalancer-ci-green-probe"
  port                = 80
}

resource "azurerm_lb_rule" "this" {
  loadbalancer_id                = azurerm_lb.this.id
  name                           = "loadbalancer-ci-test-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  disable_outbound_snat          = true
  frontend_ip_configuration_name = "loadbalancer-ci-front-green"
  probe_id                       = azurerm_lb_probe.this.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.this.id]
}

resource "azurerm_lb_outbound_rule" "this" {
  name                    = "loadbalancer-ci-green-outbound"
  loadbalancer_id         = azurerm_lb.this.id
  protocol                = "Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.this.id

  frontend_ip_configuration {
    name = "loadbalancer-ci-front-green"
  }
}

