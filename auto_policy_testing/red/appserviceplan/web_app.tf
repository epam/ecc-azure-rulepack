resource "azurerm_service_plan" "this" {
  name                          = module.naming.resource_prefix.serviceplan
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group
  os_type             = "Linux"
  sku_name            = "B1"

  tags = module.naming.default_tags
}