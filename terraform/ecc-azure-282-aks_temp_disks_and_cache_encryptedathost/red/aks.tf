resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-red"
  location = var.location
  tags     = var.tags
}

resource "azurerm_kubernetes_cluster" "this" {
  name                = "aks${var.prefix}red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = "aks${var.prefix}red"


  default_node_pool {
    name                   = "default"
    node_count             = 1
    vm_size                = "Standard_D2_v2"
    enable_host_encryption = false
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}