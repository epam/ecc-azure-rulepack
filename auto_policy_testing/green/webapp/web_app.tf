resource "azurerm_service_plan" "this" {
  name                = "sp-webapp-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  os_type             = "Linux"
  sku_name            = "B1"

  tags = var.tags
}

resource "azurerm_linux_web_app" "this" {
  name                = "app-webapp-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  service_plan_id     = azurerm_service_plan.this.id
  https_only          = true
  client_certificate_enabled = true

  identity {
    type = "UserAssigned"
    identity_ids = [ azurerm_user_assigned_identity.this.id ]
  }

  key_vault_reference_identity_id = azurerm_user_assigned_identity.this.id

  site_config {
    ftps_state = "FtpsOnly"
    http2_enabled = true
    remote_debugging_enabled = false
    application_stack {
      python_version = "3.12"
    }
    cors {
      allowed_origins = ["google.com"]
    }
  }

  auth_settings {
    enabled = true
  }

  logs {
    detailed_error_messages = true
    failed_request_tracing = true
  }

  provisioner "local-exec" {
    command = "az webapp config set -g $resourceGroup  -n $resourceName --min-tls-version '1.3'"

    environment = {
      resourceGroup = azurerm_resource_group.this.name
      resourceName = "app-webapp-green"
    }
  }

  tags = var.tags
}
