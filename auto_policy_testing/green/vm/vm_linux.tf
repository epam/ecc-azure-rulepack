resource "azurerm_linux_virtual_machine" "this" {
  name                            = "linuxvm-vm-green"
  resource_group_name             = azurerm_resource_group.this.name
  location                        = azurerm_resource_group.this.location
  size                            = "Standard_DS2_v2"
  disable_password_authentication = true
  admin_username                  = random_string.this.result
  availability_set_id             = azurerm_availability_set.this.id

  admin_ssh_key {
    username   = random_string.this.result
    public_key = file("~/.ssh/id_rsa.pub")
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

  tags = var.tags

}