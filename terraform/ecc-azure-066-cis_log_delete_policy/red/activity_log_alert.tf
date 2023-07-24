resource "azurerm_monitor_action_group" "this" {
  name                = "ag${var.prefix}red"
  resource_group_name = azurerm_resource_group.this.name
  short_name          = "ag${var.prefix}red"

  email_receiver {
    name          = "receiver-red"
    email_address = var.email
  }

}
resource "azurerm_monitor_activity_log_alert" "this" {
  name                = "red_alert-${var.prefix}"
  resource_group_name = azurerm_resource_group.this.name
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${azurerm_resource_group.this.name}"]

  criteria {
    operation_name = "Microsoft.Authorization/policyAssignments/delete"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }

  tags = var.tags
}