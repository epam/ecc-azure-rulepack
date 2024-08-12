output "front-door" {
  value = {
    front-door = azurerm_frontdoor.this.id
  }
}