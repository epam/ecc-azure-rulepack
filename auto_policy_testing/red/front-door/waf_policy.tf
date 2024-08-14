resource "azurerm_frontdoor_firewall_policy" "this" {
  name                              = "wafpolicy${random_integer.this.result}red"
  resource_group_name               = data.terraform_remote_state.common.outputs.resource_group
  enabled                           = true
  mode                              = "Prevention"
  redirect_url                      = "https://www.contoso.com"
  custom_block_response_status_code = 403
  custom_block_response_body        = "PGh0bWw+CjxoZWFkZXI+PHRpdGxlPkhlbGxvPC90aXRsZT48L2hlYWRlcj4KPGJvZHk+CkhlbGxvIHdvcmxkCjwvYm9keT4KPC9odG1sPg=="

  managed_rule {
    type    = "DefaultRuleSet"
    version = "1.0"

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

  managed_rule {
    type    = "Microsoft_BotManagerRuleSet"
    version = "1.0"
  }

  tags = module.naming.default_tags
}