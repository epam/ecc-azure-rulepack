resource "azurerm_search_service" "this" {
  name                = module.naming.resource_prefix.search
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  sku                 = "standard"

  tags = module.naming.default_tags
}