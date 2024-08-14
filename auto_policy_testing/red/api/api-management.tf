resource "azurerm_api_management" "this" {
  name                 = "${module.naming.resource_prefix.apimanagement}-${random_integer.apimgmt_num.result}"
  location             = data.terraform_remote_state.common.outputs.location
  resource_group_name  = data.terraform_remote_state.common.outputs.resource_group
  publisher_name       = "org_autotestcigreen"
  publisher_email      = "test@example.com"
  
  sku_name = "Consumption_0"
}
