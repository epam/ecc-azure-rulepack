output "key_vault_id" {
    value =   azurerm_key_vault.this.id
}

output "key_name" {
    value = azurerm_key_vault_key.this.name
}

output "vnet_id" {
    value = azurerm_virtual_network.this.id
}

output "subnet_id" {
    value = azurerm_subnet.this.id
}

output "public_ip" {
    value = azurerm_public_ip.this.ip_address
}