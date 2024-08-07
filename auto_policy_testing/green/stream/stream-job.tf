data "azurerm_client_config" "current" {}

resource "azurerm_stream_analytics_job" "this" {
  name                                     = module.naming.resource_prefix.stream
  location                                 = data.terraform_remote_state.common.outputs.location
  resource_group_name                      = data.terraform_remote_state.common.outputs.resource_group
  compatibility_level                      = "1.2"
  data_locale                              = "en-GB"
  events_late_arrival_max_delay_in_seconds = 60
  events_out_of_order_max_delay_in_seconds = 50
  events_out_of_order_policy               = "Adjust"
  output_error_policy                      = "Drop"
  streaming_units                          = 3

  tags = module.naming.default_tags

  transformation_query = <<QUERY
    SELECT *
    INTO [YourOutputAlias]
    FROM [YourInputAlias]
QUERY

}