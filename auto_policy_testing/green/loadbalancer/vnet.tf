resource "azurerm_network_interface" "nif1" {
  name                = "${module.naming.resource_prefix.networkinterface}-loadbalancer1"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  ip_configuration {
    name                          = "loadbalancer1-vm-green"
    subnet_id                     = data.terraform_remote_state.common.outputs.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = module.naming.default_tags
}

resource "azurerm_network_interface" "nif2" {
  name                = "${module.naming.resource_prefix.networkinterface}-loadbalancer2"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  ip_configuration {
    name                          = "loadbalancer2-vm-green"
    subnet_id                     = data.terraform_remote_state.common.outputs.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = module.naming.default_tags
  
}

resource "azurerm_network_interface_backend_address_pool_association" "this1" {

  network_interface_id    = azurerm_network_interface.nif1.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.this.id
}

resource "azurerm_network_interface_backend_address_pool_association" "this2" {
  network_interface_id    = azurerm_network_interface.nif2.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.this.id
}