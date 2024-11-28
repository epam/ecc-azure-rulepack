resource "azurerm_machine_learning_workspace" "this" {
  name                    = "mlwsp${var.prefix}green"
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
  name                = "this-green-vnet"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_subnet" "this" {
  name                 = "this-green-subnet"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.1.0.0/24"]
}

resource "azurerm_machine_learning_compute_instance" "this" {
  name                          = "mlci${var.prefix}green"
  machine_learning_workspace_id = azurerm_machine_learning_workspace.this.id
  virtual_machine_size          = "STANDARD_DS2_V2"
  authorization_type            = "personal"
  
  subnet_resource_id = azurerm_subnet.this.id
  description        = "foo"
  
  tags = var.tags
}