resource "azurerm_kubernetes_cluster" "this" {
  name                = module.naming.resource_prefix.aks
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  dns_prefix          = "aks${random_string.this.result}green"
  kubernetes_version  = "1.29.2"

  azure_policy_enabled = true

  local_account_disabled = true

  private_cluster_enabled = true

  disk_encryption_set_id = azurerm_disk_encryption_set.this.id

  default_node_pool {
    name            = "default"
    node_count      = 4
    vm_size         = "Standard_DS2_v2"
    os_disk_size_gb = 30
    enable_host_encryption = true
  }

  identity {
    type = "SystemAssigned"
  }

  azure_active_directory_role_based_access_control {
    managed            = true
    azure_rbac_enabled = true
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }

  tags = module.naming.default_tags
}

resource "azurerm_kubernetes_cluster" "this1" {
  name                = "${module.naming.resource_prefix.aks}-1"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  dns_prefix          = "aks${random_string.this.result}green1"

  api_server_access_profile {
    authorized_ip_ranges = ["10.0.0.0/27"]
  }

  default_node_pool {
    name            = "default"
    node_count      = 4
    vm_size         = "Standard_DS2_v2"
    os_disk_size_gb = 30
  }

  identity {
    type = "SystemAssigned"
  }

  tags = module.naming.default_tags
}