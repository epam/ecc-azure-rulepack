resource "azurerm_network_interface" "this" {
  name                  = module.naming.resource_prefix.networkinterface
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

resource "azurerm_linux_virtual_machine" "this" {
  name                            = "${module.naming.resource_prefix.vm}nicrd"
  location                        = data.terraform_remote_state.common.outputs.location
  resource_group_name             = data.terraform_remote_state.common.outputs.resource_group
  size                            = "Standard_F2"
  admin_username                  = random_string.this.result
  admin_password                  = random_password.this.result
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.this.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  tags = module.naming.default_tags
}