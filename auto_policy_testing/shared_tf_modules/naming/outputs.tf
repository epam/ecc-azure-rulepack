output "resource_prefix" {
  value = {
    vm                      = "vm",
    vmss                    = "vmss",
    networkinterface        = "${local.suffix}-${var.resource_type}-networkinterface-${local.compliance_status}",
    recoveryvault           = "${local.suffix}-${var.resource_type}-recoveryvault-${local.compliance_status}",
    keyvault                = "keyvault${local.compliance_status}",
    keyvaultkey             = "keyvaultkey${local.compliance_status}",
    keyvaultsecret          = "keyvaultsecret${local.compliance_status}",
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
    funcapp                 = "${local.suffix}-${var.resource_type}-funcapp-${local.compliance_status}",
    serviceplan             = "${local.suffix}-${var.resource_type}-serviceplan-${local.compliance_status}",
    useridentity            = "${local.suffix}-${var.resource_type}-useridentity-${local.compliance_status}",
    diagnosticsetting       = "${local.suffix}-${var.resource_type}-diagnosticsetting-${local.compliance_status}",
    synapse                 = "${local.suffix}-${var.resource_type}-synapse-${local.compliance_status}",
    sql-database            = "${local.suffix}-${var.resource_type}-sql-database-${local.compliance_status}",
    sql-server              = "${local.suffix}-${var.resource_type}-sql-server-${local.compliance_status}",
    sql-managed-instance    = "${local.suffix}-${var.resource_type}-sql-managed-instance-${local.compliance_status}",
    failovergroup           = "${local.suffix}-${var.resource_type}-failovergroup-${local.compliance_status}",
    mysql-flexibleserver    = "${local.suffix}-${var.resource_type}-mysql-flexibleserver-${local.compliance_status}",
    monitor-action-group    = "${local.suffix}-${var.resource_type}-monitor-action-group-${local.compliance_status}",
    monitor-activity-log-alert  = "${local.suffix}-${var.resource_type}-monitor-activity-log-alert-${local.compliance_status}",
    disk                    = "${local.suffix}-${var.resource_type}-disk-${local.compliance_status}",
    encryptionset           = "${local.suffix}-${var.resource_type}-encryptionset-${local.compliance_status}",
    snapshot                = "${local.suffix}-${var.resource_type}-snapshot-${local.compliance_status}",
    postgresql-server       = "${local.suffix}-${var.resource_type}-postgresql-server-${local.compliance_status}",
    cosmosdb                = "${local.suffix}-${var.resource_type}-cosmosdb-${local.compliance_status}",
    signalr                 = "${local.suffix}${var.resource_type}signalr${local.compliance_status}",
    appinsights             = "${local.suffix}${var.resource_type}appinsights${local.compliance_status}",
    spring                  = "${local.suffix}-${var.resource_type}-spring-${local.compliance_status}",
    search                  = "${local.suffix}-${var.resource_type}-search-${local.compliance_status}",
    service-fabric          = "${local.suffix}fabr${local.compliance_status}",
    stream                  = "${local.suffix}-${var.resource_type}-stream-${local.compliance_status}",
    redis                   = "${local.suffix}-${var.resource_type}-redis-${local.compliance_status}",
    servicebus              = "${local.suffix}-${var.resource_type}-servicebus-${local.compliance_status}",
    roledefinition          = "${local.suffix}-${var.resource_type}-roledefinition-${local.compliance_status}",
    ml-workspace            = "${local.suffix}ml-workspace${local.compliance_status}",
    ml-cluster              = "${local.suffix}ml-cluster${local.compliance_status}",
    logic-app               = "${local.suffix}-${var.resource_type}-logic-app-${local.compliance_status}",
    kusto                   = "${local.suffix}kusto${local.compliance_status}",
    aks                     = "${local.suffix}-${var.resource_type}-aks-${local.compliance_status}",
    iothub                  = "${local.suffix}-${var.resource_type}-iothub-${local.compliance_status}",
    eventgrid               = "${local.suffix}-${var.resource_type}-eventgrid-${local.compliance_status}",
    eventgridtopic          = "${local.suffix}-${var.resource_type}-eventgridtopic-${local.compliance_status}",
    databricksws            = "${local.suffix}-${var.resource_type}-databricksws-${local.compliance_status}",
    datafactory             = "${local.suffix}-${var.resource_type}-datafactory-${local.compliance_status}",
    containerregistry       = "${local.suffix}${var.resource_type}containerregistry${local.compliance_status}",
    cognitive               = "${local.suffix}-${var.resource_type}-cognitive-${local.compliance_status}",
    batch                   = "${local.suffix}${var.resource_type}batch${local.compliance_status}",
    automation              = "${local.suffix}-${var.resource_type}-automation-${local.compliance_status}",
    appgw                   = "${local.suffix}-${var.resource_type}-appgw-${local.compliance_status}",
    appconf                 = "${local.suffix}-${var.resource_type}-appconf-${local.compliance_status}",
    apimanagement           = "${local.suffix}-${var.resource_type}-apimanagement-${local.compliance_status}",
    alertlogs               = "${local.suffix}-${var.resource_type}-alertlogs-${local.compliance_status}",
    frontdoor-profile       = "${local.suffix}-${var.resource_type}-frontdoor-profile-${local.compliance_status}",
    frontdoor-domain        = "${local.suffix}-${var.resource_type}-frontdoor-domain-${local.compliance_status}",
    frontdoor-endpoint      = "${local.suffix}-${var.resource_type}-frontdoor-endpoint-${local.compliance_status}",
    frontdoor-route         = "${local.suffix}-${var.resource_type}-frontdoor-route-${local.compliance_status}",
    frontdoor-origin        = "${local.suffix}-${var.resource_type}-frontdoor-origin-${local.compliance_status}",
    frontdoor-origin-gr     = "${local.suffix}-${var.resource_type}-frontdoor-origin-gr-${local.compliance_status}",
    appenv                  = "${local.suffix}-${var.resource_type}-appenv-${local.compliance_status}",
    waf                     = "${local.suffix}-${var.resource_type}-waf-${local.compliance_status}"
  }
}

output "default_tags" {
  value = local.default_tags
}

