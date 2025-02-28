resource "azurerm_dns_zone" "this" {
  name                = "sub-domain-green.domain.com"
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  tags                = module.naming.default_tags
}

resource "azurerm_cdn_frontdoor_profile" "this" {
  name                = module.naming.resource_prefix.frontdoor-profile
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  sku_name            = "Standard_AzureFrontDoor"

  tags                = module.naming.default_tags
}

resource "azurerm_cdn_frontdoor_custom_domain" "this" {
  name                     = module.naming.resource_prefix.frontdoor-domain
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
  dns_zone_id              = azurerm_dns_zone.this.id
  host_name                = "contosogreen.fabrikam.com"

  tls {
    certificate_type    = "ManagedCertificate"
  }
}

resource "azurerm_cdn_frontdoor_endpoint" "this" {
  name                     = module.naming.resource_prefix.frontdoor-endpoint
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id

  tags                     = module.naming.default_tags
}

resource "azurerm_cdn_frontdoor_route" "this" {
  name                          = module.naming.resource_prefix.frontdoor-route
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.this.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.this.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.this.id]
  enabled                       = true

  forwarding_protocol    = "HttpsOnly"
  https_redirect_enabled = true
  patterns_to_match      = ["/*"]
  supported_protocols    = ["Http", "Https"]

  cdn_frontdoor_custom_domain_ids = [azurerm_cdn_frontdoor_custom_domain.this.id]
  link_to_default_domain          = false

  cache {
    query_string_caching_behavior = "IgnoreSpecifiedQueryStrings"
    query_strings                 = ["account", "settings"]
    compression_enabled           = true
    content_types_to_compress     = ["text/html", "text/javascript", "text/xml"]
  }
}

resource "azurerm_cdn_frontdoor_custom_domain_association" "this" {
  cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.this.id
  cdn_frontdoor_route_ids        = [azurerm_cdn_frontdoor_route.this.id]
}