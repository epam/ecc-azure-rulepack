resource "azurerm_snapshot" "this" {
  name                = module.naming.resource_prefix.snapshot
  location             = data.terraform_remote_state.common.outputs.location
  resource_group_name  = data.terraform_remote_state.common.outputs.resource_group
  create_option       = "Copy"
  source_uri          = azurerm_managed_disk.this1.id
}