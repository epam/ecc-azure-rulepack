data "azurerm_client_config" "current" {}

resource "azurerm_kubernetes_cluster" "this" {
  name                = module.naming.resource_prefix.aks
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  dns_prefix          = "aks${random_string.this.result}red"

  azure_policy_enabled = false

  local_account_disabled = false

  private_cluster_enabled = false

  

  default_node_pool {
    name            = "default"
    node_count      = 1
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
    enable_host_encryption = false
  }

  identity {
    type = "SystemAssigned"
  }

  tags = module.naming.default_tags
}