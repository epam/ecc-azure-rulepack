output "vnet_id" {
    value = azurerm_virtual_network.this.id
}

output "subnet_id" {
    value = azurerm_subnet.this.id
}

output "storage_id" {
    value =   azurerm_storage_account.this.id
}

output "container_name" {
    value =   azurerm_storage_container.this.name
}

output "storage_endpoint" {
    value =   azurerm_storage_account.this.primary_blob_endpoint
}

output "storage_name" {
    value =   azurerm_storage_account.this.name
}

output "storage_key" {
    value =   azurerm_storage_account.this.primary_access_key
    sensitive = true
}