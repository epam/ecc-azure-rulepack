resource "azurerm_web_application_firewall_policy" "this" {
  name                = "${var.prefix}-red-wafpolicy"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location

  policy_settings {
    enabled                     = false
    mode                        = "Prevention"
  }

  managed_rules {
    managed_rule_set {
      type    = "OWASP"
      version = "3.2"
    }
  }
}