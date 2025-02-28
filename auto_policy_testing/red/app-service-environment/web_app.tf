resource "azurerm_service_plan" "this" {
  name                = module.naming.resource_prefix.serviceplan
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  os_type             = "Linux"
  sku_name            = "B1"
  app_service_environment_id = azurerm_app_service_environment_v3.this.id

  tags = module.naming.default_tags
}

resource "azurerm_virtual_network" "this" {
  name                = module.naming.resource_prefix.vnet
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "this" {
  name                 = module.naming.resource_prefix.subnet
  resource_group_name  = data.terraform_remote_state.common.outputs.resource_group
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.2.0/24"]

  delegation {
    name = "Microsoft.Web.hostingEnvironments"
    service_delegation {
      name    = "Microsoft.Web/hostingEnvironments"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

resource "azurerm_app_service_environment_v3" "this" {
  name                = module.naming.resource_prefix.appenv
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  subnet_id           = azurerm_subnet.this.id

  cluster_setting {
    name  = "DisableTls1.0"
    value = "0"
  }

  tags = module.naming.default_tags
}
