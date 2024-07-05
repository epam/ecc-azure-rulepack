resource "azurerm_windows_virtual_machine" "this" {
  name                  = "${module.naming.resource_prefix.vm}rdwin"
  location              = data.terraform_remote_state.common.outputs.location
  resource_group_name   = data.terraform_remote_state.common.outputs.resource_group
  network_interface_ids = [azurerm_network_interface.nic1.id]
  size                  = "Standard_B1s"
  admin_username        = random_string.this.result
  admin_password        = random_password.this.result

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-datacenter-gensecond"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}