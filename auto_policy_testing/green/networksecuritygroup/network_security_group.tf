resource "azurerm_network_security_group" "this" {
  name                = "networksecuritygroup-nsg-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name

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

  provisioner "local-exec" {
    command = "terraform import azurerm_network_watcher.this /subscriptions/f7dc8823-4f06-4346-9de0-badbe6273a54/resourceGroups/NetworkWatcherRG/providers/Microsoft.Network/networkWatchers/NetworkWatcher_northeurope"

    environment = {}
  }

  tags = var.tags
}

resource "azurerm_network_watcher" "this" {
  name                = "NetworkWatcher_northeurope"
  location            = "northeurope"
  resource_group_name = "NetworkWatcherRG"
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "networksecuritygroup-cisnsgflowloganalytics-law"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "PerGB2018"
}

resource "azurerm_network_watcher_flow_log" "this" {
  network_watcher_name = azurerm_network_watcher.this.name
  resource_group_name  = azurerm_resource_group.this.name
  name                 = "networksecuritygroup-cisnsgflowloganalytics-log"

  network_security_group_id = azurerm_network_security_group.this.id
  storage_account_id        = data.terraform_remote_state.common.outputs.storage_id
  enabled                   = true

  retention_policy {
    enabled = true
    days    = 7
  }
  traffic_analytics {
    enabled               = true
    workspace_id          = azurerm_log_analytics_workspace.this.workspace_id
    workspace_region      = azurerm_log_analytics_workspace.this.location
    workspace_resource_id = azurerm_log_analytics_workspace.this.id
    interval_in_minutes   = 10
  }
}



