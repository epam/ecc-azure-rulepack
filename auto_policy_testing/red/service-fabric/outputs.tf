output "service-fabric" {
  value = {
    service-fabric-cluster = azurerm_service_fabric_cluster.this.id
  }
}