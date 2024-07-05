output "resource_prefix" {
  value = {
    vm                      = "vm",
    vmss                    = "vmss",
    networkinterface        = "${local.suffix}-${var.resource_type}-networkinterface-${local.compliance_status}",
    recoveryvault           = "${local.suffix}-${var.resource_type}-recoveryvault-${local.compliance_status}",
    keyvault                = "keyvault${local.compliance_status}",
    loganalytics            = "${local.suffix}loganalytics${local.compliance_status}",
    storage                 = "storage${local.compliance_status}",
    resourcegroup           = "${local.suffix}-${var.resource_type}-resourcegroup-${local.compliance_status}",
    vnet                    = "${local.suffix}-${var.resource_type}-vnet-${local.compliance_status}",
    subnet                  = "${local.suffix}-${var.resource_type}-subnet-${local.compliance_status}",
    publicip                = "${local.suffix}-${var.resource_type}-publicip-${local.compliance_status}",
    keyvault-key            = "${local.suffix}-keyvault-key-${local.compliance_status}",
    loadbalancer            = "${local.suffix}-${var.resource_type}-loadbalancer-${local.compliance_status}",
    availabilityset         = "${local.suffix}-${var.resource_type}-availabilityset-${local.compliance_status}",
    networksecuritygroup    = "${local.suffix}-${var.resource_type}-networksecuritygroup-${local.compliance_status}",
    privateendpoint         = "${local.suffix}-${var.resource_type}-networksecuritygroup-${local.compliance_status}",
    webapp                  = "${local.suffix}-${var.resource_type}-webapp-${local.compliance_status}",
    serviceplan             = "${local.suffix}-${var.resource_type}-serviceplan-${local.compliance_status}",
    useridentity            = "${local.suffix}-${var.resource_type}-useridentity-${local.compliance_status}",
    diagnosticsetting       = "${local.suffix}-${var.resource_type}-diagnosticsetting-${local.compliance_status}"
  }
}

output "default_tags" {
  value = local.default_tags
}

