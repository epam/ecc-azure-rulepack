resource "azurerm_api_management" "this" {
  name                 = "${module.naming.resource_prefix.apimanagement}-${random_integer.apimgmt_num.result}"
  location             = data.terraform_remote_state.common.outputs.location
  resource_group_name  = data.terraform_remote_state.common.outputs.resource_group
  publisher_name       = "org_autotestcigreen"
  publisher_email      = "test@example.com"
  virtual_network_type = "Internal"

  virtual_network_configuration {
    subnet_id = data.terraform_remote_state.common.outputs.subnet_id
  }

  client_certificate_enabled = true
  
  sku_name = "Developer_1"

  identity {
    type = "SystemAssigned"
  }

  tags = module.naming.default_tags
}

resource "azurerm_api_management_certificate" "example" {
  name                = "green-apimgmt-cert"
  api_management_name = azurerm_api_management.this.name
  resource_group_name = data.terraform_remote_state.common.outputs.resource_group

  key_vault_secret_id = azurerm_key_vault_certificate.this.secret_id
}