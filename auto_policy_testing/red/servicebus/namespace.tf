resource "azurerm_servicebus_namespace" "this" {
  name                = module.naming.resource_prefix.servicebus
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  sku                 = "Standard"

  tags = module.naming.default_tags
}