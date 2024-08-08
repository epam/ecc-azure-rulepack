resource "azurerm_key_vault" "this" {
  name                = "${module.naming.resource_prefix.keyvault}ml${random_integer.this.result}"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  tags                = module.naming.default_tags
}