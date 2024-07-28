output "subscription" {
  value = {
    subscription = data.azurerm_client_config.current.subscription_id
  }
}