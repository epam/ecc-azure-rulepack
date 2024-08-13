resource "azurerm_network_interface" "nic1" {
  name                = "${module.naming.resource_prefix.networkinterface}-vmva"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  ip_configuration {
    name                          = "confva1-vm-green"
    subnet_id                     = data.terraform_remote_state.common.outputs.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = module.naming.default_tags
}

resource "azurerm_windows_virtual_machine" "this" {
  name                  = "${module.naming.resource_prefix.vm}grva"

  location              = data.terraform_remote_state.common.outputs.location
  resource_group_name   = data.terraform_remote_state.common.outputs.resource_group
  network_interface_ids = [azurerm_network_interface.nic1.id]
  size                  = "Standard_DS2_v2"
  admin_username        = random_string.this.result
  admin_password        = random_password.this.result

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

resource "azurerm_security_center_server_vulnerability_assessment_virtual_machine" "this" {
  virtual_machine_id = azurerm_windows_virtual_machine.this.id
}

