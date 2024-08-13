output "event" {
  value = {
    event-grid-domain = azurerm_eventgrid_domain.this.id,
    event-grid-topic = azurerm_eventgrid_topic.this.id
  }
}