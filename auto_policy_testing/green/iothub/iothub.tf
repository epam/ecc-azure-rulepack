data "azurerm_client_config" "current" {}

resource "azurerm_iothub" "this" {
  name                = module.naming.resource_prefix.iothub
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  public_network_access_enabled = false

  sku {
    name     = "S1"
    capacity = "1"
  }

  tags = module.naming.default_tags
}