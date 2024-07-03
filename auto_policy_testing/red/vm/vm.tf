resource "azurerm_windows_virtual_machine" "this" {
  name                  = "winvm-vm-red"
  location              = azurerm_resource_group.this.location
  resource_group_name   = azurerm_resource_group.this.name
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