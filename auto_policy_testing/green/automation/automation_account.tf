resource "azurerm_automation_account" "this" {
  name                          = module.naming.resource_prefix.automation
  location                      = "eastasia"
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group
  sku_name                      = "Basic"
  tags                          = module.naming.default_tags
}