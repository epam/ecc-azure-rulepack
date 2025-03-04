resource "azurerm_linux_virtual_machine" "linuxvm1" {
  name                            = "442linuxvmgreen1"
  location                        = data.terraform_remote_state.common.outputs.location
  resource_group_name             = data.terraform_remote_state.common.outputs.resource_group
  size                            = "Standard_B1ms"
  admin_username                  = random_string.this.result
  admin_password                  = random_password.this.result
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nif1.id
  ]

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

resource "azurerm_linux_virtual_machine" "linuxvm2" {
  name                            = "442linuxvmgreen2"
  location                        = data.terraform_remote_state.common.outputs.location
  resource_group_name             = data.terraform_remote_state.common.outputs.resource_group
  size                            = "Standard_B1ms"
  admin_username                  = random_string.this.result
  admin_password                  = random_password.this.result
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.nif2.id
  ]

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