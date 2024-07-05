resource "azurerm_windows_virtual_machine" "this" {
  name                  = "${module.naming.resource_prefix.vm}win"

  location              = data.terraform_remote_state.common.outputs.location
  resource_group_name   = data.terraform_remote_state.common.outputs.resource_group
  network_interface_ids = [azurerm_network_interface.nic1.id]
  size                  = "Standard_DS2_v2"
  admin_username        = random_string.this.result
  admin_password        = random_password.this.result
  secure_boot_enabled   = true
  vtpm_enabled          = true
  availability_set_id   = azurerm_availability_set.this.id

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-datacenter-gensecond"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = module.naming.default_tags
}

