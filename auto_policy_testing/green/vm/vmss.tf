resource "azurerm_windows_virtual_machine_scale_set" "this" {
  name                            = "${module.naming.resource_prefix.vmss}win"
  location                        = data.terraform_remote_state.common.outputs.location
  resource_group_name             = data.terraform_remote_state.common.outputs.resource_group
  sku                             = "Standard_DS2_v2"
  instances                       = 1
  admin_username                  = random_string.this.result
  admin_password                  = random_password.this.result
  encryption_at_host_enabled      = true

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
    name    = "nic-vm4-green"
    primary = true

    ip_configuration {
      name      = "conf4-vm-green"
      primary   = true
      subnet_id = data.terraform_remote_state.common.outputs.subnet_id
    }
  }
  tags = module.naming.default_tags
}