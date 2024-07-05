resource "azurerm_network_security_group" "this" {
  name                  = module.naming.resource_prefix.networksecuritygroup
  location              = data.terraform_remote_state.common.outputs.location
  resource_group_name   = data.terraform_remote_state.common.outputs.resource_group

  security_rule {
    name                       = "allow_inbound_udp"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }



  security_rule {
    name                       = "allow_inbound_all"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }



  tags = module.naming.default_tags
}

