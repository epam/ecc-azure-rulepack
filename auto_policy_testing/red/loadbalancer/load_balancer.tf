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
    name                 = "loadbalancer-ci-front-red"
    public_ip_address_id = azurerm_public_ip.this.id
  }

  tags = module.naming.default_tags
}

resource "azurerm_lb_backend_address_pool" "this" {
  loadbalancer_id      = azurerm_lb.this.id
  name                 = "loadbalancer-ci-red-pool"
}

