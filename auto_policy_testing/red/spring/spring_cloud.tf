data "azurerm_client_config" "current" {}

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

  tags = module.naming.default_tags

  depends_on = [ azurerm_application_insights.this ]
}