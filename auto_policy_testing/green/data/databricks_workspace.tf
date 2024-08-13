resource "azurerm_databricks_workspace" "this" {
  name                = module.naming.resource_prefix.databricksws
  location            = data.terraform_remote_state.common.outputs.location
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group
  sku                 = "standard"

  custom_parameters {
    no_public_ip                                         = true
    virtual_network_id                                   = azurerm_virtual_network.this.id
    private_subnet_name                                  = azurerm_subnet.this.name
    public_subnet_name                                   = azurerm_subnet.this1.name
    private_subnet_network_security_group_association_id = azurerm_subnet_network_security_group_association.this.id
    public_subnet_network_security_group_association_id  = azurerm_subnet_network_security_group_association.this1.id
  }

  public_network_access_enabled = false
  network_security_group_rules_required = "NoAzureServiceRules"


  tags = module.naming.default_tags
}