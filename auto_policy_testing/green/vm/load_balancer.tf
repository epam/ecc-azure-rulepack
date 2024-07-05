resource "azurerm_lb" "this" {
  name                = module.naming.resource_prefix.loadbalancer
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicFrontend"
    public_ip_address_id = data.terraform_remote_state.common.outputs.public_ip_id
  }

  tags = module.naming.default_tags
}

resource "azurerm_lb_backend_address_pool" "this" {
  loadbalancer_id = azurerm_lb.this.id
  name            = "publicWorkerPool"
  depends_on = [ azurerm_lb ]
}

resource "azurerm_lb_rule" "this" {
  loadbalancer_id                = azurerm_lb.this.id
  name                           = "lb-rulevmss"
  protocol                       = "Tcp"
  frontend_port                  = "80"
  backend_port                   = "80"
  frontend_ip_configuration_name = "PublicFrontend"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.this.id]
  probe_id                       = azurerm_lb_probe.this.id

  depends_on = [ azurerm_lb, azurerm_lb_backend_address_pool ]
}

resource "azurerm_lb_probe" "this" {
  name            = "healthProbe-vmss"
  loadbalancer_id = azurerm_lb.this.id
  protocol        = "Tcp"
  port            = "80"

  depends_on = [ azurerm_lb, azurerm_lb_backend_address_pool, azurerm_lb_rule ]
}