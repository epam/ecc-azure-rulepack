resource "azurerm_service_plan" "this" {
  name                          = module.naming.resource_prefix.serviceplan
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group
  os_type             = "Linux"
  sku_name            = "B1"

  tags = module.naming.default_tags
}

resource "azurerm_linux_web_app" "this" {
  name                          = module.naming.resource_prefix.webapp
  location                      = data.terraform_remote_state.common.outputs.location
  resource_group_name           = data.terraform_remote_state.common.outputs.resource_group
  service_plan_id     = azurerm_service_plan.this.id
  https_only          = true

  site_config {
    application_stack {
      python_version = "3.11"
    }
  }

  tags = module.naming.default_tags
}