resource "azurerm_automation_variable_string" "this" {
  name                    = "autotestcivariable-green"
  resource_group_name     = data.terraform_remote_state.common.outputs.resource_group
  automation_account_name = azurerm_automation_account.this.name
  value                   = "Lorem ipsum"
  encrypted               = true
}