resource "azurerm_container_registry" "this" {
  name                          = module.naming.resource_prefix.containerregistry
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group
  sku                           = "Premium"
  admin_enabled                 = true
  anonymous_pull_enabled        = true

  network_rule_set {
    default_action = "Allow"
  }

  tags = module.naming.default_tags
}

