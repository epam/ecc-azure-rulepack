data "azurerm_client_config" "current" {}

resource "azurerm_monitor_action_group" "this" {
  name                = module.naming.resource_prefix.monitor-action-group
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  short_name          = "ag${random_integer.this.result}red"

  email_receiver {
    name          = "receiver-red"
    email_address = "user1@example.com"
  }

  tags = module.naming.default_tags
}

resource "azurerm_monitor_activity_log_alert" "this1" {
  name                = "${module.naming.resource_prefix.monitor-activity-log-alert}-1"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.terraform_remote_state.common.outputs.resource_group}"]

  criteria {
    operation_name = "Microsoft.Authorization/policyAssignments/write"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }

  tags = module.naming.default_tags
}

resource "azurerm_monitor_activity_log_alert" "this2" {
  name                = "${module.naming.resource_prefix.monitor-activity-log-alert}-2"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.terraform_remote_state.common.outputs.resource_group}"]

  criteria {
    operation_name = "Microsoft.Network/networkSecurityGroups/write"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }

  tags = module.naming.default_tags
}

resource "azurerm_monitor_activity_log_alert" "this3" {
  name                = "${module.naming.resource_prefix.monitor-activity-log-alert}-3"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.terraform_remote_state.common.outputs.resource_group}"]

  criteria {
    operation_name = "Microsoft.Network/networkSecurityGroups/delete"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }

  tags = module.naming.default_tags
}

resource "azurerm_monitor_activity_log_alert" "this4" {
  name                = "${module.naming.resource_prefix.monitor-activity-log-alert}-4"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.terraform_remote_state.common.outputs.resource_group}"]

  criteria {
    operation_name = "Microsoft.Security/securitySolutions/write"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }

  tags = module.naming.default_tags
}

resource "azurerm_monitor_activity_log_alert" "this5" {
  name                = "${module.naming.resource_prefix.monitor-activity-log-alert}-5"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.terraform_remote_state.common.outputs.resource_group}"]

  criteria {
    operation_name = "Microsoft.Security/securitySolutions/delete"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }

  tags = module.naming.default_tags
}

resource "azurerm_monitor_activity_log_alert" "thi6" {
  name                = "${module.naming.resource_prefix.monitor-activity-log-alert}-6"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.terraform_remote_state.common.outputs.resource_group}"]

  criteria {
    operation_name = "Microsoft.DBforMySQL/servers/firewallRules/write"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }

  tags = module.naming.default_tags
}

resource "azurerm_monitor_activity_log_alert" "this7" {
  name                = "${module.naming.resource_prefix.monitor-activity-log-alert}-7"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.terraform_remote_state.common.outputs.resource_group}"]

  criteria {
    operation_name = "Microsoft.Authorization/policyAssignments/delete"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }

  tags = module.naming.default_tags
}

resource "azurerm_monitor_activity_log_alert" "this8" {
  name                = "${module.naming.resource_prefix.monitor-activity-log-alert}-8"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.terraform_remote_state.common.outputs.resource_group}"]

  criteria {
    operation_name = "Microsoft.Network/networkSecurityGroups/securityRules/write"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }

  tags = module.naming.default_tags
}

resource "azurerm_monitor_activity_log_alert" "this9" {
  name                = "${module.naming.resource_prefix.monitor-activity-log-alert}-9"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.terraform_remote_state.common.outputs.resource_group}"]

  criteria {
    operation_name = "Microsoft.Network/networkSecurityGroups/securityRules/delete"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }

  tags = module.naming.default_tags
}

resource "azurerm_monitor_activity_log_alert" "this10" {
  name                = "${module.naming.resource_prefix.monitor-activity-log-alert}-10"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.terraform_remote_state.common.outputs.resource_group}"]

  criteria {
    operation_name = "Microsoft.Network/publicIPAddresses/write"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }

  tags = module.naming.default_tags
}

resource "azurerm_monitor_activity_log_alert" "this11" {
  name                = "${module.naming.resource_prefix.monitor-activity-log-alert}-11"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${data.terraform_remote_state.common.outputs.resource_group}"]

  criteria {
    operation_name = "Microsoft.Network/publicIPAddresses/delete"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }

  tags = module.naming.default_tags
}

resource "time_sleep" "wait_10_minutes" {
  depends_on = [azurerm_monitor_activity_log_alert.this11]

  create_duration = "10m"
}