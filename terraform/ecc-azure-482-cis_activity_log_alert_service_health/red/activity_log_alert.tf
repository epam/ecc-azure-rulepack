data "azurerm_client_config" "current" {}

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
  location            = "global"
  criteria {
    operation_name = "Microsoft.Network/publicIPAddresses/delete"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }

  tags = var.tags
}

resource "azurerm_monitor_activity_log_alert" "this1" {
  name                = "red_alert1-${var.prefix}"
  resource_group_name = azurerm_resource_group.this.name
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${azurerm_resource_group.this.name}"]
  location            = var.location
  criteria {
    operation_name = "Microsoft.Network/publicIPAddresses/delete"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }

  tags = var.tags
}

resource "azurerm_monitor_activity_log_alert" "this2" {
  name                = "red_alert2-${var.prefix}"
  resource_group_name = azurerm_resource_group.this.name
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${azurerm_resource_group.this.name}"]
  location            = "global"
  enabled             = false
  criteria {
    operation_name = "Microsoft.Network/publicIPAddresses/delete"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }

  tags = var.tags
}

resource "azurerm_monitor_activity_log_alert" "this3" {
  name                = "red_alert3-${var.prefix}"
  resource_group_name = azurerm_resource_group.this.name
  scopes              = ["/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${azurerm_resource_group.this.name}"]
  location            = "global"
  criteria {
    operation_name = "Microsoft.Network/publicIPAddresses/delete"
    category       = "Administrative"
  }

  tags = var.tags
}