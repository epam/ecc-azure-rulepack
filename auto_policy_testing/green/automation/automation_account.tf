resource "azurerm_automation_account" "this" {
  name                          = "${module.naming.resource_prefix.automation}${random_integer.this.result}"
  location                      = "eastus"
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group
  sku_name                      = "Basic"
  tags                          = module.naming.default_tags
}