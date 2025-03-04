data "azurerm_client_config" "current" {}

resource "azurerm_machine_learning_workspace" "this" {
  name                    = module.naming.resource_prefix.ml-workspace
  location                = data.terraform_remote_state.common.outputs.location
  resource_group_name     = data.terraform_remote_state.common.outputs.resource_group
  application_insights_id = azurerm_application_insights.this.id
  key_vault_id            = data.terraform_remote_state.common.outputs.key_vault_id
  storage_account_id      = data.terraform_remote_state.common.outputs.storage_id

  identity {
    type = "SystemAssigned"
  }

  encryption {
    key_vault_id = data.terraform_remote_state.common.outputs.key_vault_id
    key_id       = data.terraform_remote_state.common.outputs.key_id
  }

  tags = module.naming.default_tags
}

resource "azurerm_machine_learning_compute_cluster" "this" {
  name                          = module.naming.resource_prefix.ml-cluster
  location                      = data.terraform_remote_state.common.outputs.location
  vm_priority                   = "Dedicated"
  vm_size                       = "STANDARD_F2S_V2"
  machine_learning_workspace_id = azurerm_machine_learning_workspace.this.id
  subnet_resource_id            = data.terraform_remote_state.common.outputs.subnet_id

  scale_settings {
    min_node_count                       = 0
    max_node_count                       = 1
    scale_down_nodes_after_idle_duration = "PT30S" # 30 seconds
  }

  identity {
    type = "SystemAssigned"
  }

  tags = module.naming.default_tags
}

resource "null_resource" "ml_compute_instance" {
  provisioner "local-exec" {
    command = "az ml compute create -f compute-instance.yml --resource-group $resourceGroup --workspace-name $workspaceName"

    environment = {
      resourceGroup = data.terraform_remote_state.common.outputs.resource_group
      workspaceName = azurerm_machine_learning_workspace.this.name
    }
  }

  depends_on = [ azurerm_machine_learning_workspace.this ]
}