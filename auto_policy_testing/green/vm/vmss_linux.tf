resource "azurerm_linux_virtual_machine_scale_set" "this" {
  name                            = "lss-vm-green"
  resource_group_name             = azurerm_resource_group.this.name
  location                        = azurerm_resource_group.this.location
  sku                             = "Standard_DS2_v2"
  disable_password_authentication = true
  admin_username                  = random_string.this.result
  instances                       = 1
  encryption_at_host_enabled      = true
  upgrade_mode                    = "Automatic"


  admin_ssh_key {
    username   = random_string.this.result
    public_key = var.public_key
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
    name    = "nic-vm3-green"
    primary = true

    ip_configuration {
      name      = "conf3-vm-green"
      primary   = true
      subnet_id = data.terraform_remote_state.common.outputs.subnet_id
      load_balancer_backend_address_pool_ids = [
        azurerm_lb_backend_address_pool.this.id
      ]
    }
  }

  health_probe_id = azurerm_lb_probe.this.id

  automatic_os_upgrade_policy {
    disable_automatic_rollback  = false
    enable_automatic_os_upgrade = true
  }

  tags = var.tags
}

