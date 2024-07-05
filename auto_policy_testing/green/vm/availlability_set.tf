resource "azurerm_availability_set" "this" {
  name                = module.naming.resource_prefix.availabilityset
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  tags = module.naming.default_tags
}