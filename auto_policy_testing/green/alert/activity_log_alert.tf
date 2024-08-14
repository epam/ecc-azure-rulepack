data "azurerm_client_config" "current" {}

resource "azurerm_monitor_action_group" "this" {
  name                = "agautotestcigreen"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  short_name          = "agautotestcigreen"

  email_receiver {
    name          = "receiver-green"
    email_address = "test@test.com"
  }

}
resource "azurerm_monitor_activity_log_alert" "this" {
  name                = module.naming.resource_prefix.alertlogs
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}"]

  criteria {
    operation_name = "Microsoft.Authorization/policyAssignments/write"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }

  tags = module.naming.default_tags
}