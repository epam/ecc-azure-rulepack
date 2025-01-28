resource "azurerm_machine_learning_workspace" "this" {
  name                    = "mlwsp${var.prefix}green1"
  location                = azurerm_resource_group.this.location
  resource_group_name     = azurerm_resource_group.this.name
  application_insights_id = azurerm_application_insights.this.id
  key_vault_id            = azurerm_key_vault.this.id
  storage_account_id      = azurerm_storage_account.this.id

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

resource "azurerm_virtual_network" "this" {
  name                = "${var.prefix}-green-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet" "this" {
  name                 = "${var.prefix}-green-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.1.0.0/24"]
}

resource "null_resource" "ml_compute_instance" {
  provisioner "local-exec" {
    command = "az ml compute create -f compute-instance.yml --resource-group $resourceGroup --workspace-name $workspaceName"

    environment = {
      resourceGroup = azurerm_resource_group.this.name
      workspaceName = azurerm_machine_learning_workspace.this.name
    }
  }

  depends_on = [ azurerm_machine_learning_workspace.this ]
}