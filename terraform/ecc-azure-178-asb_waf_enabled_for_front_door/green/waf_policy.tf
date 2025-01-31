resource "azurerm_cdn_frontdoor_firewall_policy" "this" {
  name                              = "green${var.prefix}cdnfdwafpolicy"
  resource_group_name               = azurerm_resource_group.this.name
  sku_name                          = azurerm_cdn_frontdoor_profile.this.sku_name
  enabled                           = true
  mode                              = "Prevention"

  managed_rule {
    type    = "Microsoft_BotManagerRuleSet"
    version = "1.0"
    action  = "Log"
  }
}

resource "azurerm_cdn_frontdoor_security_policy" "this" {
  name                     = "Green-${var.prefix}-Security-Policy"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id

  security_policies {
    firewall {
      cdn_frontdoor_firewall_policy_id = azurerm_cdn_frontdoor_firewall_policy.this.id

      association {
        domain {
          cdn_frontdoor_domain_id = azurerm_cdn_frontdoor_custom_domain.this.id
        }
        patterns_to_match = ["/*"]
      }
    }
  }
}