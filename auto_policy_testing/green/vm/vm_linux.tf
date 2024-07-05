resource "azurerm_linux_virtual_machine" "this" {
  name                            = "${module.naming.resource_prefix.vm}lin"
  location                        = data.terraform_remote_state.common.outputs.location
  resource_group_name             = data.terraform_remote_state.common.outputs.resource_group
  size                            = "Standard_DS2_v2"
  disable_password_authentication = true
  admin_username                  = random_string.this.result
  availability_set_id             = azurerm_availability_set.this.id

  admin_ssh_key {
    username   = random_string.this.result
    public_key = var.public_key
  }

  network_interface_ids = [
    azurerm_network_interface.nic2.id
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

  identity {
    type = "SystemAssigned"
  }

  tags = module.naming.default_tags

}