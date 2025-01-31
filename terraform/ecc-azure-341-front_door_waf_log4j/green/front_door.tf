resource "azurerm_dns_zone" "this" {
  name                = "sub-domain-green.domain.com"
  resource_group_name = azurerm_resource_group.this.name

  tags = var.tags
}

resource "azurerm_cdn_frontdoor_profile" "this" {
  name                = "${var.prefix}-green-profile"
  resource_group_name = azurerm_resource_group.this.name
  sku_name            = "Premium_AzureFrontDoor"

  tags = var.tags
}

resource "azurerm_cdn_frontdoor_custom_domain" "this" {
  name                     = "${var.prefix}-green-customDomain"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
  dns_zone_id              = azurerm_dns_zone.this.id
  host_name                = "contosogreen.fabrikam.com"

  tls {
    certificate_type    = "ManagedCertificate"
  }
}

resource "azurerm_cdn_frontdoor_endpoint" "this" {
  name                     = "${var.prefix}-green-end"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id

  tags = var.tags
}
