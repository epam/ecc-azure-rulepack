resource "azurerm_service_fabric_cluster" "this" {
  name                 = "sf${var.prefix}red"
  resource_group_name  = azurerm_resource_group.this.name
  location             = azurerm_resource_group.this.location
  reliability_level    = "Bronze"
  upgrade_mode         = "Manual"
  cluster_code_version = "8.2.1571.9590"
  vm_image             = "Windows"
  management_endpoint  = "https://example:80"

  node_type {
    name                 = "first"
    instance_count       = 3
    is_primary           = true
    client_endpoint_port = 2020
    http_endpoint_port   = 80
  }

  fabric_settings {
    name = "Security"
  }
}