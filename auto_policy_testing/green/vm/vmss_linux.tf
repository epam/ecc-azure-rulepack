resource "azurerm_linux_virtual_machine_scale_set" "this" {
  name                            = "${module.naming.resource_prefix.vmss}grlin"
  location                        = data.terraform_remote_state.common.outputs.location
  resource_group_name             = data.terraform_remote_state.common.outputs.resource_group
  sku                             = "Standard_DS2_v2"
  disable_password_authentication = true
  admin_username                  = random_string.this.result
  instances                       = 1
  encryption_at_host_enabled      = true
  upgrade_mode                    = "Automatic"


  admin_ssh_key {
    username   = random_string.this.result
    public_key = tls_private_key.this.public_key_openssh
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

  tags = module.naming.default_tags

  depends_on = [ azurerm_lb_rule.this, azurerm_lb_probe.this ]
}

resource "azurerm_linux_virtual_machine_scale_set" "this1" {
  name                            = "${module.naming.resource_prefix.vmss}gr1lin"
  location                        = data.terraform_remote_state.common.outputs.location
  resource_group_name             = data.terraform_remote_state.common.outputs.resource_group
  sku                             = "Standard_DS2_v2"
  disable_password_authentication = true
  admin_username                  = random_string.this.result
  instances                       = 1  


  admin_ssh_key {
    username   = random_string.this.result
    public_key = tls_private_key.this.public_key_openssh
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
    name    = "nic-vm7-green"
    primary = true

    ip_configuration {
      name      = "conf7-vm-green"
      primary   = true
      subnet_id = data.terraform_remote_state.common.outputs.subnet_id
    }
  }

  tags = module.naming.default_tags
}

