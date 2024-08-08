output "aks" {
  value = {
    aks = azurerm_kubernetes_cluster.this.id
  }
}