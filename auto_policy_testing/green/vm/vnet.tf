resource "azurerm_network_interface" "nic1" {
  name                = "${module.naming.resource_prefix.networkinterface}-vm1"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  ip_configuration {
    name                          = "conf1-vm-green"
    subnet_id                     = data.terraform_remote_state.common.outputs.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = module.naming.default_tags
}

resource "azurerm_network_interface" "nic2" {
  name                = "${module.naming.resource_prefix.networkinterface}-vm2"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  ip_configuration {
    name                          = "conf2-vm-green"
    subnet_id                     = data.terraform_remote_state.common.outputs.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = module.naming.default_tags
}

resource "azurerm_network_interface" "nic3" {
  name                = "${module.naming.resource_prefix.networkinterface}-vm3"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  ip_configuration {
    name                          = "conf3-vm-green"
    subnet_id                     = data.terraform_remote_state.common.outputs.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = module.naming.default_tags
}
