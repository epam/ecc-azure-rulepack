resource "azurerm_eventgrid_topic" "this" {
  name                          = module.naming.resource_prefix.eventgridtopic
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group

  tags = module.naming.default_tags
}