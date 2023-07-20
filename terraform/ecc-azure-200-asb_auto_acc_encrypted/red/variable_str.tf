resource "azurerm_automation_variable_string" "this" {
  name                    = "${var.prefix}variable-red"
  resource_group_name     = azurerm_resource_group.this.name
  automation_account_name = azurerm_automation_account.this.name
  value                   = "Lorem ipsum"
  encrypted               = false
}