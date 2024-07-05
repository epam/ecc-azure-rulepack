resource "azurerm_virtual_network" "this" {
  name                = module.naming.resource_prefix.vnet
  address_space       = ["10.0.0.0/24"]
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  tags = module.naming.default_tags
}

resource "azurerm_subnet" "this" {
  name                  = module.naming.resource_prefix.subnet
  resource_group_name   = data.terraform_remote_state.common.outputs.resource_group
  virtual_network_name  = azurerm_virtual_network.this.name
  address_prefixes      = ["10.0.0.0/27"]
}