output "subscription" {
  value = {
    subscription = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  }
}