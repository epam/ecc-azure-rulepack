resource "azurerm_kubernetes_cluster" "this" {
  name                = "aks-${var.prefix}"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = "test-${var.prefix}"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  api_server_authorized_ip_ranges = ["10.0.0.0/27"]

  tags = var.tags
}