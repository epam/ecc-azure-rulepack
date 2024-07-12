resource "azurerm_network_interface" "thisnsg" {
  name                  = "${module.naming.resource_prefix.networkinterface}-nsg"
  location              = data.terraform_remote_state.common.outputs.location
  resource_group_name   = data.terraform_remote_state.common.outputs.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.terraform_remote_state.common.outputs.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
  enable_ip_forwarding = true

  tags = module.naming.default_tags
}

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

resource "azurerm_network_interface_security_group_association" "assoc_nic" {
  network_interface_id      = azurerm_network_interface.thisnsg.id
  network_security_group_id = azurerm_network_security_group.this.id
}
