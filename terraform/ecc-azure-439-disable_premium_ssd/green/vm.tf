resource "azurerm_windows_virtual_machine" "this" {
  name                = "${var.prefix}winvmgreen"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  size                = "Standard_B1ms"
  admin_username      = random_string.this.result
  admin_password      = random_password.this.result

  network_interface_ids = [
    azurerm_network_interface.this.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  tags = var.tags
}