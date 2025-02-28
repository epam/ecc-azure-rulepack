resource "azurerm_cdn_frontdoor_origin_group" "this" {
  name                     = module.naming.resource_prefix.frontdoor-origin-gr
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id

  load_balancing {
    additional_latency_in_milliseconds = 0
    sample_size                        = 16
    successful_samples_required        = 3
  }
}

resource "azurerm_cdn_frontdoor_origin" "this" {
  name                          = module.naming.resource_prefix.frontdoor-origin
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.this.id
  enabled                       = true

  certificate_name_check_enabled = false

  host_name          = "contoso.com"
  http_port          = 80
  https_port         = 443
  origin_host_header = "www.contoso.com"
  priority           = 1
  weight             = 1
}