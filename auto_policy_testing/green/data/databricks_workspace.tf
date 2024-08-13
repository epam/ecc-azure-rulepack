resource "azurerm_databricks_workspace" "this" {
  name                = module.naming.resource_prefix.databricksws
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  sku                 = "standard"

  public_network_access_enabled = false

  tags = module.naming.default_tags
}