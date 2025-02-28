output "afd" {
  value = {
    afd-custom-domain = azurerm_cdn_frontdoor_custom_domain.this.id
  }
}