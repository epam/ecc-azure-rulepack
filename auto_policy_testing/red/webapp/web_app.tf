resource "azurerm_service_plan" "this" {
  name                = module.naming.resource_prefix.serviceplan
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  os_type             = "Linux"
  sku_name            = "B1"

  tags = module.naming.default_tags
}

resource "azurerm_linux_web_app" "this" {
  name                = "${module.naming.resource_prefix.webapp}-linux"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  service_plan_id     = azurerm_service_plan.this.id
  https_only          = false
  client_certificate_enabled = false

  site_config {
    remote_debugging_enabled = true
    minimum_tls_version = "1.0"
    ftps_state = "AllAllowed"
    http2_enabled = false
    application_stack {
      python_version = "3.7"
    }
    cors {
      allowed_origins = ["*"]
    }
  }

  auth_settings {
    enabled = false
  }

  logs {
    detailed_error_messages = false
    failed_request_tracing = false
  }

  tags = module.naming.default_tags
}
