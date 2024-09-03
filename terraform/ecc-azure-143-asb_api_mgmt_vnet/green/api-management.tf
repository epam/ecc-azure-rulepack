resource "azurerm_api_management" "this" {
  name                 = "apimgmt${random_integer.apimgmt_num.result}-${var.prefix}"
  location             = azurerm_resource_group.this.location
  resource_group_name  = azurerm_resource_group.this.name
  publisher_name       = "org_${var.prefix}"
  publisher_email      = "test@example.com"
  sku_name             = "Developer_1"
  virtual_network_type = "External"

  virtual_network_configuration {
    subnet_id = azurerm_subnet.this.id
  }
  public_network_access_enabled = true

  tags = var.tags
}