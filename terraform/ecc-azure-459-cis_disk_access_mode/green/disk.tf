resource "azurerm_managed_disk" "this" {
  name                 = "${var.prefix}managed_disks_green"
  location             = azurerm_resource_group.this.location
  resource_group_name  = azurerm_resource_group.this.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1"

  tags = var.tags

  provisioner "local-exec" {
    command = "az disk update --name $resourceName --resource-group $resourceGroup --data-access-auth-mode AzureActiveDirectory"

    environment = {
      resourceGroup = azurerm_resource_group.this.name
      resourceName  = azurerm_managed_disk.this.name
    }
  }
}
