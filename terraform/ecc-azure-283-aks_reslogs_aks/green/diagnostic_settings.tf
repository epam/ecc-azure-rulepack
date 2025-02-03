resource "azurerm_storage_account" "this" {
  name                     = "ds${var.prefix}green"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name               = "${var.prefix}dsgreen"
  target_resource_id = azurerm_kubernetes_cluster.this.id
  storage_account_id = azurerm_storage_account.this.id

  enabled_log {
    category = "cloud-controller-manager"
  }

  enabled_log {
    category = "cluster-autoscaler"
  }

  enabled_log {
    category = "guard"
  }

  enabled_log {
    category = "kube-apiserver"
  }

  enabled_log {
    category = "kube-audit"
  }

  enabled_log {
    category = "kube-audit-admin"
  }

  enabled_log {
    category = "kube-controller-manager"
  }

  enabled_log {
    category = "kube-scheduler"
  }
}