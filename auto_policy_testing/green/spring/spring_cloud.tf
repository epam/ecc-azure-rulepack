data "azurerm_client_config" "current" {}

resource "azurerm_virtual_network" "this" {
  name                = module.naming.resource_prefix.vnet
  address_space       = ["10.1.0.0/16"]
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  
  tags                 = module.naming.default_tags
}

resource "azurerm_subnet" "runtime_subnet" {
  name                 = module.naming.resource_prefix.subnet
  resource_group_name  = data.terraform_remote_state.common.outputs.resource_group
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.1.2.0/24"]
}

resource "azurerm_subnet" "app_subnet" {
  name                 = module.naming.resource_prefix.subnet
  resource_group_name  = data.terraform_remote_state.common.outputs.resource_group
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.1.1.0/24"]
}

resource "azurerm_application_insights" "this" {
  name                = module.naming.resource_prefix.appinsights
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  application_type    = "web"

  tags = module.naming.default_tags
}

resource "azurerm_spring_cloud_service" "this" {
  name                = module.naming.resource_prefix.spring
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  sku_name            = "S0"

  network {
    app_subnet_id = azurerm_subnet.app_subnet.id
    service_runtime_subnet_id = azurerm_subnet.runtime_subnet.id
    cidr_ranges = ["10.0.0.0/16", "10.2.0.0/16", "10.3.0.1/16"]
  }

  tags = module.naming.default_tags
}