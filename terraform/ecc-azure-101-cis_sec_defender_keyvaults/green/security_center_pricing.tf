#Changing the pricing tier to Standard affects all resources of the given type in the subscription and could be quite costly.

resource "azurerm_security_center_subscription_pricing" "pricing" {
  tier          = "Standard"
  resource_type = "KeyVaults"
}