resource "azurerm_network_interface" "this" {
  name                  = module.naming.resource_prefix.networkinterface
  location              = data.terraform_remote_state.common.outputs.location
  resource_group_name   = data.terraform_remote_state.common.outputs.resource_group

  ip_configuration {
    name                          = "internal"
    subnet_id = data.terraform_remote_state.common.outputs.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = module.naming.default_tags
}

resource "azurerm_network_interface_security_group_association" "assoc_nic" {
  network_interface_id      = azurerm_network_interface.this.id
  network_security_group_id = azurerm_network_security_group.this.id
}