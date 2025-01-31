resource "azurerm_cdn_frontdoor_firewall_policy" "this" {
  name                              = "red${var.prefix}cdnfdwafpolicy"
  resource_group_name               = azurerm_resource_group.this.name
  sku_name                          = azurerm_cdn_frontdoor_profile.this.sku_name
  enabled                           = true
  mode                              = "Prevention"
  redirect_url                      = "https://www.contoso.com"
  custom_block_response_status_code = 403
  custom_block_response_body        = "PGh0bWw+CjxoZWFkZXI+PHRpdGxlPkhlbGxvPC90aXRsZT48L2hlYWRlcj4KPGJvZHk+CkhlbGxvIHdvcmxkCjwvYm9keT4KPC9odG1sPg=="

  
  managed_rule {
    type    = "DefaultRuleSet"
    version = "1.0"
    action = "block"

    exclusion {
      match_variable = "QueryStringArgNames"
      operator       = "Equals"
      selector       = "not_suspicious"
    }

    override {
      rule_group_name = "JAVA"

      rule {
        rule_id = "944240"
        enabled = false
        action  = "Block"
      }
    }

  }
}

resource "azurerm_cdn_frontdoor_security_policy" "this" {
  name                     = "red-${var.prefix}-Security-Policy"
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