resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-green"
  location = "eastus"
  tags     = var.tags
}

resource "azurerm_kubernetes_cluster" "this" {
  name                   = "${var.prefix}kubernetes"
  location               = azurerm_resource_group.this.location
  resource_group_name    = azurerm_resource_group.this.name
  dns_prefix             = "aksthisdnsprefix1"
  disk_encryption_set_id = azurerm_disk_encryption_set.this.id

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name                   = "nodepool${var.prefix}"
    node_count             = 1
    vm_size                = "Standard_DS2_v2"
    os_disk_type           = "Managed"
    enable_host_encryption = true
  }
}

resource "azurerm_disk_encryption_set" "this" {
  name                = "des${var.prefix}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  key_vault_key_id    = azurerm_key_vault_key.this.id

  identity {
    type = "SystemAssigned"
  }
}