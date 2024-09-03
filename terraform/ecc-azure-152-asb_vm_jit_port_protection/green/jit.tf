resource "azurerm_security_center_subscription_pricing" "this" {
  tier          = "Standard"
  resource_type = "VirtualMachines"
}

resource "azapi_resource" "jit" {
  type      = "Microsoft.Security/locations/jitNetworkAccessPolicies@2020-01-01"
  name      = "LinuxJITPolicy"
  parent_id = "${azurerm_resource_group.this.id}/providers/Microsoft.Security/locations/${var.location}"
  body = jsonencode({
    properties = {
      virtualMachines = [
        {
          id = "${azurerm_linux_virtual_machine.this.id}"
          ports = [
            {
              maxRequestAccessDuration   = "PT3H"
              number                     = 22
              protocol                   = "*"
              allowedSourceAddressPrefix = "*"
            }
          ]
        }
      ]
    }
    kind = "Basic"
  })

  depends_on = [ azurerm_subnet_network_security_group_association.this ]
}