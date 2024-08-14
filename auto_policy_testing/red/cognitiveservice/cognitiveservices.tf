resource "azurerm_cognitive_account" "this" {
  name                          = module.naming.resource_prefix.cognitive
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group
  kind                          = "Face"

  public_network_access_enabled = "true"

  sku_name = "F0"

  network_acls {
    default_action = "Allow"
  }

  tags = module.naming.default_tags
}