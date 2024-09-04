resource "azurerm_linux_virtual_machine" "this" {
  name                            = "linuxvm${var.prefix}-green"
  resource_group_name             = azurerm_resource_group.this.name
  location                        = azurerm_resource_group.this.location
  size                            = "Standard_D2s_v3"
  disable_password_authentication = false
  admin_username                  = random_string.this.result
  admin_password                  = random_password.this.result
  allow_extension_operations      = true

  network_interface_ids = [
    azurerm_network_interface.this.id,
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

  tags = var.tags
}