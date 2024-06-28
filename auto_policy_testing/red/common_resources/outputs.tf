output "vnet_id" {
    value = azurerm_virtual_network.this.id
}

output "subnet_id" {
    value = azurerm_subnet.this.id
}

output "storage_id" {
    value =   azurerm_storage_account.this.id
}

output "storage_name" {
    value =   azurerm_storage_account.this.name
}

output "storage_key" {
    value =   azurerm_storage_account.this.primary_access_key
    sensitive = true
}