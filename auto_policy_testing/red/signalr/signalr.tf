resource "azurerm_signalr_service" "this" {
  name                = module.naming.resource_prefix.signalr
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  sku {
    name     = "Standard_S1"
    capacity = 1
  }

  tags = module.naming.default_tags
}