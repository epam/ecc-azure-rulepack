resource "azurerm_dns_zone" "this" {
  name                = "sub-domain.domain.com"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_cdn_frontdoor_profile" "this" {
  name                = "this-green-profile"
  resource_group_name = azurerm_resource_group.this.name
  sku_name            = "Standard_AzureFrontDoor"
}

resource "azurerm_cdn_frontdoor_custom_domain" "this" {
  name                     = "this-green-customDomain"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.this.id
  dns_zone_id              = azurerm_dns_zone.this.id
  host_name                = "contoso.fabrikam.com"

  tls {
    certificate_type    = "ManagedCertificate"
    minimum_tls_version = "TLS12"
  }
}