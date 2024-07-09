output "synapse" {
  value = {
    synapse = azurerm_synapse_workspace.this.id
  }
}