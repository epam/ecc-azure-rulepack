resource "azurerm_linux_virtual_machine" "this" {
  name                            = "${var.prefix}-vm-green"
  location                        = azurerm_resource_group.this.location
  resource_group_name             = azurerm_resource_group.this.name
  size                            = "Standard_F2s"
  admin_username                  = random_string.this.result
  admin_password                  = random_password.this.result
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    name                   = "${var.prefix}disk_green"
    caching                = "ReadWrite"
    storage_account_type   = "Standard_LRS"
  }

  tags = var.tags
}