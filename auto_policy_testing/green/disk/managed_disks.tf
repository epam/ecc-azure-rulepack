resource "azurerm_managed_disk" "this1" {
  name                 = "${module.naming.resource_prefix.disk}-1"
  location             = data.terraform_remote_state.common.outputs.location
  resource_group_name  = data.terraform_remote_state.common.outputs.resource_group
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1"

  disk_encryption_set_id = azurerm_disk_encryption_set.this.id

  tags = module.naming.default_tags

  depends_on = [ azurerm_key_vault_access_policy.this ]
}

resource "azurerm_managed_disk" "this2" {
  name                 = "${module.naming.resource_prefix.disk}-2"
  location             = data.terraform_remote_state.common.outputs.location
  resource_group_name  = data.terraform_remote_state.common.outputs.resource_group
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1"

  disk_encryption_set_id = azurerm_disk_encryption_set.this.id

  tags = module.naming.default_tags

  depends_on = [ azurerm_key_vault_access_policy.this ]
}