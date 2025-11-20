resource "azurerm_app_service" "this" {
  name                = "${module.naming.resource_prefix.webapp}-appservice"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  app_service_plan_id     = azurerm_service_plan.this.id
}