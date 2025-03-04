output "front-door" {
  value = {
    front-door = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourcegroups/${data.terraform_remote_state.common.outputs.resource_group}/providers/Microsoft.Network/frontdoors/${azurerm_frontdoor.this.name}",
    ecc-azure-431-dep_retired_frontdoor_classic = azurerm_cdn_frontdoor_profile.this.id
  }
}