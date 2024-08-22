resource "azurerm_service_fabric_cluster" "this" {
  name                = module.naming.resource_prefix.service-fabric
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  reliability_level    = "Bronze"
  upgrade_mode         = "Manual"
  cluster_code_version = "10.1.2338.9590"
  vm_image             = "Windows"
  management_endpoint  = "https://example:80"

  node_type {
    name                 = "first"
    instance_count       = 3
    is_primary           = true
    client_endpoint_port = 2020
    http_endpoint_port   = 80
  }

  certificate {
        thumbprint = azurerm_key_vault_certificate.this.thumbprint
        x509_store_name = "My"
    }

  tags = module.naming.default_tags

  depends_on = [ azurerm_key_vault_certificate.this ]
}