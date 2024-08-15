output "app-configuration" {
  value = {
    app-configuration = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/red-infrastructure-ci/providers/Microsoft.AppConfiguration/configurationStores/${azurerm_app_configuration.this.name}"
  }
}