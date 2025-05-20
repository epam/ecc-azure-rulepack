resource "azurerm_security_center_subscription_pricing" "this" {
  tier          = "Standard"
  resource_type = "CloudPosture"

  extension {
    name = "AgentlessVmScanning"
    additional_extension_properties = {
      ExclusionTags = "[]"
    }
  }
}