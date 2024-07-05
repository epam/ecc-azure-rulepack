resource "azurerm_network_security_group" "this" {
  name                = module.naming.resource_prefix.networksecuritygroup
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  security_rule {
    name                       = "deny_inbound_udp"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }



  security_rule {
    name                       = "deny_inbound_all"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = module.naming.default_tags
}

#remove it when azure policy will be removed
#resource "azurerm_network_watcher" "this" {
#  name                = "NetworkWatcher_northeurope"
#  location            = "northeurope"
#  resource_group_name = "NetworkWatcherRG"
#}

#resource "azurerm_log_analytics_workspace" "this" {
#  name                = "networksecuritygroup-cisnsgflowloganalytics-law"
#  location            = azurerm_resource_group.this.location
#  resource_group_name = azurerm_resource_group.this.name
#  sku                 = "PerGB2018"
#}

#resource "azurerm_network_watcher_flow_log" "this" {
#  network_watcher_name = "NetworkWatcher_northeurope" #this update too when policy will be removed
#  resource_group_name  = "NetworkWatcherRG" #this update too when policy will be removed
#  name                 = "networksecuritygroup-cisnsgflowloganalytics-log"

#  network_security_group_id = azurerm_network_security_group.this.id
#  storage_account_id        = data.terraform_remote_state.common.outputs.storage_id
#  enabled                   = true

#  retention_policy {
#    enabled = true
#    days    = 7
#  }
#  traffic_analytics {
#    enabled               = true
#    workspace_id          = azurerm_log_analytics_workspace.this.workspace_id
#    workspace_region      = azurerm_log_analytics_workspace.this.location
#    workspace_resource_id = azurerm_log_analytics_workspace.this.id
#    interval_in_minutes   = 10
#  }
#}



