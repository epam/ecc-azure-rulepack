data "azurerm_client_config" "current" {}

resource "azurerm_service_plan" "this" {
  name                = "sp-${var.prefix}-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  os_type             = "Linux"
  sku_name            = "B1"

  tags = var.tags
}

resource "azurerm_linux_web_app" "this" {
  name                = "app-${var.prefix}-green"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  service_plan_id     = azurerm_service_plan.this.id
  https_only          = true

  site_config {}

  tags = var.tags

  provisioner "local-exec" {
    command = "az webapp config set -g $resourceGroup  -n $resourceName --linux-fx-version 'PHP|8.3'"

    environment = {
      resourceGroup = azurerm_resource_group.this.name
      resourceName = "app-${var.prefix}-green"
    }
  }
}