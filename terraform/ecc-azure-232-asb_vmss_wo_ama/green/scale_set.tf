resource "azurerm_virtual_network" "this" {
  name                = "${var.prefix}-vnet"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  address_space       = ["10.40.0.0/16"]
}

resource "azurerm_subnet" "this" {
  name                 = "${var.prefix}-sub"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.40.2.0/24"]
}

resource "azurerm_windows_virtual_machine_scale_set" "vmsswin1" {
  name                = "greenwin"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Standard_F2"
  instances           = 1
  admin_password      = "P@55w0rd1234!!!"
  admin_username      = "adminuser"

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter-Server-Core"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "vinvnet"
    primary = true

    ip_configuration {
      name      = "Test12vnet-sub"
      primary   = true
      subnet_id = azurerm_subnet.this.id
    }
  }
}

resource "azurerm_linux_virtual_machine_scale_set" "vmsslin2" {
  name                            = "greenlin"
  resource_group_name             = azurerm_resource_group.this.name
  location                        = azurerm_resource_group.this.location
  sku                             = "Standard_F2"
  instances                       = 1
  admin_password                  = "P@55w0rd1234!!!"
  admin_username                  = "adminuser"
  disable_password_authentication = "false"

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
    name    = "linvnet"
    primary = true

    ip_configuration {
      name      = "Test12vnet-sub"
      primary   = true
      subnet_id = azurerm_subnet.this.id
    }
  }
}