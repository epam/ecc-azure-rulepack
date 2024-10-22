resource "azurerm_service_plan" "this1" {
  name                = "sp1-${var.prefix}-red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  os_type             = "Linux"
  sku_name            = "B1"

  tags = var.tags
}

resource "azurerm_service_plan" "this2" {
  name                = "sp2-${var.prefix}-red"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  os_type             = "Windows"
  sku_name            = "B1"

  tags = var.tags
}

resource "azurerm_storage_account" "this" {
  name                     = "sa${var.prefix}red"
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = var.tags
}

resource "azurerm_linux_function_app" "this" {
  name                       = "functions${var.prefix}linux-red"
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  service_plan_id            = azurerm_service_plan.this1.id
  storage_account_name       = azurerm_storage_account.this.name
  storage_account_access_key = azurerm_storage_account.this.primary_access_key

  site_config {
    application_stack {
      java_version = "8"
    }
  }

  tags = var.tags
}

resource "azurerm_windows_function_app" "this" {
  name                       = "functions${var.prefix}win-red"
  location                   = azurerm_resource_group.this.location
  resource_group_name        = azurerm_resource_group.this.name
  service_plan_id            = azurerm_service_plan.this2.id
  storage_account_name       = azurerm_storage_account.this.name
  storage_account_access_key = azurerm_storage_account.this.primary_access_key

  site_config {
    application_stack {
      java_version = "1.8"
    }
  }

  tags = var.tags
}