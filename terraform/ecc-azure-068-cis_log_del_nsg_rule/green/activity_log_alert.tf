resource "azurerm_monitor_action_group" "this" {
  name                = "ag${var.prefix}green"
  resource_group_name = azurerm_resource_group.this.name
  short_name          = "ag${var.prefix}green"

  email_receiver {
    name          = "receiver-green"
    email_address = var.email
  }

}
resource "azurerm_monitor_activity_log_alert" "this" {
  name                = "green_alert-${var.prefix}"
  resource_group_name = azurerm_resource_group.this.name
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}"]

  criteria {
    operation_name = "Microsoft.Network/networkSecurityGroups/securityRules/delete"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }

  tags = var.tags
}