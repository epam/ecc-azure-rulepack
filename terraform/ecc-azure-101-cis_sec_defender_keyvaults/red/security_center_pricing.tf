resource "azurerm_security_center_subscription_pricing" "pricing" {
  tier          = "Free"
  resource_type = "KeyVaults"
}