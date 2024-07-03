resource "azurerm_windows_virtual_machine_scale_set" "this" {
  name                = "Wssvmred"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "Standard_F2"
  instances           = 1
  admin_username                  = random_string.this.result
  admin_password                  = random_password.this.result

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
    name    = "nic-vm5-red"
    primary = true

    ip_configuration {
      name      = "conf5-vm-red"
      primary   = true
      subnet_id = data.terraform_remote_state.common.outputs.subnet_id
    }
  }
  tags = var.tags
}