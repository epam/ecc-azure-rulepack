resource "azurerm_linux_function_app" "python1" {
  name                       = "${module.naming.resource_prefix.funcapp}-python1"
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

resource "azurerm_linux_function_app" "python2" {
  name                       = "${module.naming.resource_prefix.funcapp}-python2"
  location                   = data.terraform_remote_state.common.outputs.location
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  service_plan_id            = azurerm_service_plan.this.id
  storage_account_name       = data.terraform_remote_state.common.outputs.storage_name
  storage_account_access_key = data.terraform_remote_state.common.outputs.storage_key
  client_certificate_enabled = false
  site_config {
    application_stack {
      python_version = "3.9"
    }
  }

  tags = module.naming.default_tags
}

resource "azurerm_linux_function_app" "java1" {
  name                       = "${module.naming.resource_prefix.funcapp}-java1"
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

resource "azurerm_linux_function_app" "java2" {
  name                       = "${module.naming.resource_prefix.funcapp}-java2"
  location                   = data.terraform_remote_state.common.outputs.location
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  service_plan_id            = azurerm_service_plan.this.id
  storage_account_name       = data.terraform_remote_state.common.outputs.storage_name
  storage_account_access_key = data.terraform_remote_state.common.outputs.storage_key
  site_config {
    
    application_stack {
      java_version = "11"
    }
  }

  tags = module.naming.default_tags
}

resource "azurerm_linux_function_app" "powershell1" {
  name                       = "${module.naming.resource_prefix.funcapp}-powershell1"
  location                   = data.terraform_remote_state.common.outputs.location
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  service_plan_id            = azurerm_service_plan.this.id
  storage_account_name       = data.terraform_remote_state.common.outputs.storage_name
  storage_account_access_key = data.terraform_remote_state.common.outputs.storage_key

  site_config {
    application_stack {
      powershell_core_version = 7.2
    }
  }

  tags = module.naming.default_tags
}

resource "azurerm_linux_function_app" "dot1" {
  name                       = "${module.naming.resource_prefix.funcapp}-dot1"
  location                   = data.terraform_remote_state.common.outputs.location
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  service_plan_id            = azurerm_service_plan.this.id
  storage_account_name       = data.terraform_remote_state.common.outputs.storage_name
  storage_account_access_key = data.terraform_remote_state.common.outputs.storage_key

  site_config {
    application_stack {
      dotnet_version = "7.0"
    }
  }

  tags = module.naming.default_tags
}

resource "azurerm_linux_function_app" "dot2" {
  name                       = "${module.naming.resource_prefix.funcapp}-dot2"
  location                   = data.terraform_remote_state.common.outputs.location
  resource_group_name        = data.terraform_remote_state.common.outputs.resource_group
  service_plan_id            = azurerm_service_plan.this.id
  storage_account_name       = data.terraform_remote_state.common.outputs.storage_name
  storage_account_access_key = data.terraform_remote_state.common.outputs.storage_key

  site_config {
    application_stack {
      dotnet_version = "8.0"
    }
  }

  tags = module.naming.default_tags
}