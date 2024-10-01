resource "azurerm_api_management" "this" {
  name                 = "${module.naming.resource_prefix.apimanagement}-${random_integer.apimgmt_num.result}"
  location             = data.terraform_remote_state.common.outputs.location
  resource_group_name  = data.terraform_remote_state.common.outputs.resource_group
  publisher_name       = "org_autotestcigreen"
  publisher_email      = "test@example.com"

  client_certificate_enabled = true
  
  sku_name = "Consumption_0"

  identity {
    type = "SystemAssigned"
  }

  tags = module.naming.default_tags

  timeouts {
    create = "2h"
    delete = "2h"
  }
}

resource "azurerm_api_management" "this1" {
  name                 = "${module.naming.resource_prefix.apimanagement}-${random_integer.apimgmt_num.result}-1"
  location             = data.terraform_remote_state.common.outputs.location
  resource_group_name  = data.terraform_remote_state.common.outputs.resource_group
  publisher_name       = "org_autotestcigreen1"
  publisher_email      = "test1@example.com"
  virtual_network_type = "External"

  public_network_access_enabled = true

  virtual_network_configuration {
    subnet_id = azurerm_subnet.this.id
  }

  sku_name = "Developer_1"

  tags = module.naming.default_tags

  timeouts {
    create = "2h"
    delete = "2h"
  }

  depends_on = [ azurerm_subnet_network_security_group_association.this ]
}

resource "azurerm_api_management_certificate" "this" {
  name                = "green-apimgmt-cert1${random_integer.apimgmt_num.result}"
  api_management_name = azurerm_api_management.this.name
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  key_vault_secret_id = azurerm_key_vault_certificate.this.secret_id

  depends_on = [ azurerm_key_vault_access_policy.api ]
}