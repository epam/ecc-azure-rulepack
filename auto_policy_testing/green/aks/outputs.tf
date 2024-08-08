output "aks" {
  value = {
    aks = azurerm_kubernetes_cluster.this.id,
    ecc-azure-144-asb_aks_auth_ip_ranges = azurerm_kubernetes_cluster.this1.id
  }
}