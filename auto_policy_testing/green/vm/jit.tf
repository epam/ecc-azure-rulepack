resource "azapi_resource" "jit" {
  type = "Microsoft.Security/locations/jitNetworkAccessPolicies@2020-01-01"
  name = "myPolicy"
  parent_id = "${data.terraform_remote_state.common.outputs.resource_group_id}/providers/Microsoft.Security/locations/northeurope"
  body = jsonencode({
    properties = {
      virtualMachines = [
        {
          id = azurerm_linux_virtual_machine.this.id
          ports = [
            {
              maxRequestAccessDuration   = "PT3H"
              number                     = 22
              protocol                   = "*"
              allowedSourceAddressPrefix = "*"
            },
             {
              maxRequestAccessDuration   = "PT3H"
              number                     = 3389
              protocol                   = "*"
              allowedSourceAddressPrefix = "*"
            
            }
          ]
        }
      ]
    }
    kind = "Basic"
  })
}