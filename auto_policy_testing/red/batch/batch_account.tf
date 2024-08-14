resource "azurerm_batch_account" "this" {
  name                          = module.naming.resource_prefix.batch
  location                      = "eastus"
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group
  pool_allocation_mode          = "BatchService"
  
  tags = module.naming.default_tags
}