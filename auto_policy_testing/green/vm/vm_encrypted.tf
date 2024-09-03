resource "azurerm_linux_virtual_machine" "this1" {
  name                            = "${module.naming.resource_prefix.vm}g1lin"
  location                        = data.terraform_remote_state.common.outputs.location
  resource_group_name             = data.terraform_remote_state.common.outputs.resource_group
  size                            = "Standard_D2s_v3"
  disable_password_authentication = true
  admin_username                  = random_string.this.result
  allow_extension_operations      = true

  admin_ssh_key {
    username   = random_string.this.result
    public_key = tls_private_key.this.public_key_openssh
  }

  network_interface_ids = [
    azurerm_network_interface.nic4.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 64
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