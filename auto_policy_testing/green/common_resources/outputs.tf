output "resource_group" {
    value =   azurerm_resource_group.resources.name
}

output "location" {
    value = var.location
}


output "key_vault_id" {
    value =   azurerm_key_vault.this.id
}

output "key_vault_url" {
    value =   azurerm_key_vault.this.vault_uri
}

output "key_vault_name" {
    value =   azurerm_key_vault.this.name
}

output "key_name" {
    value = azurerm_key_vault_key.this.name
}

output "key_id" {
    value = azurerm_key_vault_key.this.id
}

output "user_assigned_id" {
    value = azurerm_user_assigned_identity.this.id
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

output "public_ip_id" {
    value = azurerm_public_ip.this.id
}

output "dns_id" {
  value = azurerm_private_dns_zone.this.id
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

output "storage_blob_endpoint" {
    value =   azurerm_storage_account.this.primary_blob_endpoint
    sensitive = true
}

output "workspace_key" {
    value =   azurerm_log_analytics_workspace.this.primary_shared_key
    sensitive = true
}

output "workspace_id" {
    value =   azurerm_log_analytics_workspace.this.workspace_id
}