resource "azurerm_linux_function_app" "this" {
  name                       = "functions-func-red"
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  service_plan_id            = azurerm_service_plan.this.id
  storage_account_name       = data.terraform_remote_state.common.outputs.storage_name
  storage_account_access_key = data.terraform_remote_state.common.outputs.storage_key
  client_certificate_enabled = false
  site_config {
    remote_debugging_enabled = true
    cors {
      allowed_origins = ["*"]
    }
    application_stack {
      python_version = "3.7"
    }
  }

  tags = var.tags
}