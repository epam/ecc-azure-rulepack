resource "azurerm_managed_disk" "this1" {
  name                 = "${module.naming.resource_prefix.disk}-1"
  location             = data.terraform_remote_state.common.outputs.location
  resource_group_name  = data.terraform_remote_state.common.outputs.resource_group
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1"

  tags = module.naming.default_tags
}

resource "azurerm_managed_disk" "this2" {
  name                 = "${module.naming.resource_prefix.disk}-2"
  location             = data.terraform_remote_state.common.outputs.location
  resource_group_name  = data.terraform_remote_state.common.outputs.resource_group
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1"

  tags = module.naming.default_tags
}