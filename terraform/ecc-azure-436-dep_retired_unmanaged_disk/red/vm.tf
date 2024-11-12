resource "azurerm_virtual_machine" "this" {
  name                            = "${var.prefix}rdlin-unmanaged"
  location                        = azurerm_resource_group.this.location
  resource_group_name             = azurerm_resource_group.this.name
  network_interface_ids           = [azurerm_network_interface.nif1.id]
  vm_size                         = "Standard_F2"

  delete_os_disk_on_termination = true

  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name          = "myosdisk1"
    vhd_uri       = "${azurerm_storage_account.this.primary_blob_endpoint}${azurerm_storage_container.this.name}/myosdisk1.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }
  
  os_profile {
    computer_name  = random_string.this.result
    admin_username = random_string.this.result
    admin_password = random_password.this.result
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = var.tags
}