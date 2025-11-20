resource "azurerm_service_plan" "this" {
  name                = module.naming.resource_prefix.serviceplan
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  os_type             = "Linux"
  sku_name            = "B1"

  tags = module.naming.default_tags
}

resource "azurerm_linux_web_app" "python1" {
  name                = "${module.naming.resource_prefix.webapp}-linux-python1"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  service_plan_id     = azurerm_service_plan.this.id
  https_only          = false
  client_certificate_enabled = false

  site_config {
    remote_debugging_enabled = true
    remote_debugging_version = "VS2022"
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

resource "azurerm_linux_web_app" "python2" {
  name                = "${module.naming.resource_prefix.webapp}-linux-python2"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  service_plan_id     = azurerm_service_plan.this.id

  site_config {
    application_stack {
      python_version = "3.9"
    }
  }

  tags = module.naming.default_tags
}

resource "azurerm_linux_web_app" "java1" {
  name                = "${module.naming.resource_prefix.webapp}-linux-java1"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  service_plan_id     = azurerm_service_plan.this.id

  site_config {
    application_stack {
      java_server         = "JAVA"
      java_server_version = "8"
      java_version        = "8"
    }
  }

  tags = module.naming.default_tags
}

resource "azurerm_linux_web_app" "java2" {
  name                = "${module.naming.resource_prefix.webapp}-linux-java2"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  service_plan_id     = azurerm_service_plan.this.id

  site_config {
    application_stack {
      java_server         = "JAVA"
      java_server_version = "11"
      java_version        = "11"
    }
  }

  tags = module.naming.default_tags
}

resource "azurerm_linux_web_app" "php1" {
  name                = "${module.naming.resource_prefix.webapp}-linux-php1"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  service_plan_id     = azurerm_service_plan.this.id

  site_config {
    application_stack {
      php_version = "8.2"
    }
  }

  tags = module.naming.default_tags
}

resource "azurerm_linux_web_app" "php2" {
  name                = "${module.naming.resource_prefix.webapp}-linux-php2"
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  service_plan_id     = azurerm_service_plan.this.id

  site_config {
    application_stack {
      php_version = "8.1"
    }
  }

  tags = module.naming.default_tags
}
