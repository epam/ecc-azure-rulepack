resource "azurerm_linux_function_app" "this" {
  name                       = module.naming.resource_prefix.funcapp
  location                   = data.terraform_remote_state.common.outputs.location
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  service_plan_id            = azurerm_service_plan.this.id
  storage_account_name       = data.terraform_remote_state.common.outputs.storage_name
  storage_account_access_key = data.terraform_remote_state.common.outputs.storage_key
  client_certificate_enabled = true
  https_only                 = true
  site_config {
    ftps_state               = "FtpsOnly"
    http2_enabled            = true
    remote_debugging_enabled = false
    cors {
      allowed_origins = ["google.com"]
    }
    application_stack {
      python_version = "3.12"
    } 
  }

  auth_settings {
    enabled = true
  }

  provisioner "local-exec" {
    command = "az functionapp config set -g $resourceGroup  -n $resourceName --min-tls-version '1.3'"

    environment = {
      resourceGroup = data.terraform_remote_state.common.outputs.resource_group
      resourceName  = "autotest-webapp-funcapp-green"
    }
  }


  tags = module.naming.default_tags
}