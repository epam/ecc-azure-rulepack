resource "azurerm_linux_virtual_machine_scale_set" "this" {
  name                            = "${module.naming.resource_prefix.vmss}rdlin"
  location                        = data.terraform_remote_state.common.outputs.location
  resource_group_name             = data.terraform_remote_state.common.outputs.resource_group
  sku                             = "Standard_B1s"
  disable_password_authentication = false
  admin_username                  = random_string.this.result
  instances                       = 1
  admin_password                  = random_password.this.result 
  encryption_at_host_enabled = false
  upgrade_mode                    = "Manual"

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
    name    = "nic-vm6-red"
    primary = true

    ip_configuration {
      name      = "conf6-vm-red"
      primary   = true
      subnet_id = data.terraform_remote_state.common.outputs.subnet_id
    }
  }
}

