resource "azurerm_linux_virtual_machine_scale_set" "this" {
  name                = "lss${var.prefix}-green"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Standard_B1s"
  admin_username      = random_string.this.result
  instances           = 1

  admin_ssh_key {
    username   = random_string.this.result
    public_key = file("~/.ssh/id_rsa.pub")
  }


  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "linuxvmssnic"
    primary = true

    ip_configuration {
      name      = "linuxvmssipconf"
      primary   = true
      subnet_id = azurerm_subnet.linuxvmss.id
    }
  }

  tags = var.tags
}