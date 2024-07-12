resource "azurerm_linux_function_app" "this" {
  name                       = module.naming.resource_prefix.funcapp
  location                   = data.terraform_remote_state.common.outputs.location
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  service_plan_id            = azurerm_service_plan.this.id
  storage_account_name       = data.terraform_remote_state.common.outputs.storage_name
  storage_account_access_key = data.terraform_remote_state.common.outputs.storage_key
  client_certificate_enabled = false
  site_config {
    remote_debugging_enabled = true
    remote_debugging_version = "VS2022"
    cors {
      allowed_origins = ["*"]
    }
    application_stack {
      python_version = "3.7"
    }
  }

  tags = module.naming.default_tags
}

resource "azurerm_linux_function_app" "this2" {
  name                       = "${module.naming.resource_prefix.funcapp}-2"
  location                   = data.terraform_remote_state.common.outputs.location
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  service_plan_id            = azurerm_service_plan.this.id
  storage_account_name       = data.terraform_remote_state.common.outputs.storage_name
  storage_account_access_key = data.terraform_remote_state.common.outputs.storage_key
  site_config {
    
    application_stack {
      java_version = "8"
    }
  }

  tags = module.naming.default_tags
}