resource "azurerm_network_interface" "this" {
  name                = "${module.naming.resource_prefix.networkinterface}-disk"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  ip_configuration {
    name                          = "conf1-disk-green"
    subnet_id                     = data.terraform_remote_state.common.outputs.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = module.naming.default_tags
}

resource "azurerm_virtual_machine" "this" {
  name                         = "${module.naming.resource_prefix.vm}grdisk"
  location                     = data.terraform_remote_state.common.outputs.location
  resource_group_name          = data.terraform_remote_state.common.outputs.resource_group
  network_interface_ids        = ["${azurerm_network_interface.this.id}"]
  vm_size                      = "Standard_DS1_v2"


  storage_os_disk {
    os_type           = "Linux"
    name              = "autotest-disk-disk-green-2"
    managed_disk_type = "Standard_LRS"
    caching           = "ReadWrite"
    create_option     = "Attach"
    managed_disk_id   = "${azurerm_managed_disk.this2.id}"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}