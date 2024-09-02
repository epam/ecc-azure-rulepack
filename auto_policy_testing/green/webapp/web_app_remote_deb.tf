resource "azurerm_service_plan" "remdeb" {
  name                = "${module.naming.resource_prefix.serviceplan}deb"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  os_type             = "Linux"
  sku_name            = "B1"

  tags = module.naming.default_tags
}

resource "azurerm_linux_web_app" "remdeb" {
  name                = "${module.naming.resource_prefix.webapp}-linuxdeb"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  service_plan_id            = azurerm_service_plan.remdeb.id
  client_certificate_enabled = false
  https_only                 = true

  site_config {
    remote_debugging_enabled = false
  }

  tags = module.naming.default_tags
}