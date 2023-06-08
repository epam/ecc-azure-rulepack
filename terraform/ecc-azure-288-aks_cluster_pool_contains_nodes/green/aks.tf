resource "azurerm_kubernetes_cluster" "this" {
  name                = "aks-${var.prefix}-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = "aks-${var.prefix}"

  default_node_pool {
    name       = "default"
    node_count = 4
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  tags = var.tags
}