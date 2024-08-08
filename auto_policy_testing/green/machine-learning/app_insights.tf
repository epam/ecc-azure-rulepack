resource "azurerm_application_insights" "this" {
  name                = module.naming.resource_prefix.appinsights
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  application_type    = "web"
  tags                = module.naming.default_tags
}