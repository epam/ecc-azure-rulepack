resource "azurerm_databricks_workspace" "this" {
  name                = "${var.prefix}databricks-green"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = "standard"

  custom_parameters {
    no_public_ip = true
    virtual_network_id = azurerm_virtual_network.this.id
    private_subnet_name = azurerm_subnet.this.name
    public_subnet_name = azurerm_subnet.this1.name
    public_subnet_network_security_group_association_id = azurerm_network_security_group.this.id
    private_subnet_network_security_group_association_id = azurerm_network_security_group.this.id
  }

  tags = var.tags
}