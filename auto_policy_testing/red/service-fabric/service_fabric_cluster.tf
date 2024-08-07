data "azurerm_client_config" "current" {}

resource "azurerm_service_fabric_cluster" "this" {
  name                = module.naming.resource_prefix.service-fabric
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
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

  tags = module.naming.default_tags
}