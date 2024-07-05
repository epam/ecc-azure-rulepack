resource "azurerm_linux_virtual_machine" "this" {
  name                            = "${module.naming.resource_prefix.vm}rdlin"
  location                        = data.terraform_remote_state.common.outputs.location
  resource_group_name             = data.terraform_remote_state.common.outputs.resource_group
  size                            = "Standard_B1s"
  disable_password_authentication = false
  admin_username                  = random_string.this.result
  admin_password                  = random_password.this.result

  network_interface_ids = [
    azurerm_network_interface.nic2.id,
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