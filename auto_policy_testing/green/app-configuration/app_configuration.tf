resource "azurerm_app_configuration" "this" {
  name                          = module.naming.resource_prefix.appconf
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group
  sku                 = "standard"

  tags = module.naming.default_tags
}