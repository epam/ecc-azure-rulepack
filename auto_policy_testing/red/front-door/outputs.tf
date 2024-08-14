output "front-door" {
  value = {
    front-door = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourcegroups/${data.terraform_remote_state.common.outputs.resource_group}/providers/Microsoft.Network/frontdoors/${azurerm_frontdoor.this.name}",
    ecc-azure-341-front_door_waf_log4j = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourcegroups/${data.terraform_remote_state.common.outputs.resource_group}/providers/Microsoft.Network/frontdoors/${azurerm_frontdoor.this1.name}"
  }
}