aws = {}

gcp = {}

azure = {
    "green": ["ecc-azure-109-cis_sa_logging_blob", #cannot configure via terraform or az cli
              "ecc-azure-152-asb_vm_jit_port_protection", #cannot configure via terraform or az cli
              "ecc-azure-110-cis_sa_logging_table", #cannot configure via terraform or az cli
              "ecc-azure-197-asb_vm_disk_encryption_on", #policy doesn't work
              "ecc-azure-227-asb_reslogs_vmss", #policy doesn't work
              "ecc-azure-272-asb_scaleset", #policy doesn't work
              "ecc-azure-344-mysql_threat_detection_policy", #policy doesn't work
              "ecc-azure-345-mysql_infrastructure_encryption", #policy doesn't work
              "ecc-azure-368-vmss_omi_vulnerability", #policy doesn't work
              "ecc-azure-378-cis_nsg_flow_log_analytics", #policy doesn't work
              "ecc-azure-201-asb_cosmosdb_encrypt_cmk", #policy work but need additional permissions
              "ecc-azure-203-asb_postgresql_encrypt_cmk", #policy work but terraform destroy fails pipeline
              "ecc-azure-302-redis_cache_disabled_public_access", #python sdk should be updated
              "ecc-azure-354-acr_anonymous_pull" #issue with policy, should be reviewed and fixed
              ], 
    "red": ["ecc-azure-105-cis_sa_keys_regen", #cannot configure via terraform or az cli
            "ecc-azure-157-asb_mysql_public_access_disabled", #cannot configure via terraform or az cli
            "ecc-azure-197-asb_vm_disk_encryption_on", #policy doesn't work
            "ecc-azure-227-asb_reslogs_vmss", #policy doesn't work
            "ecc-azure-258-asb_remotedebug_web", #terraform issue
            "ecc-azure-272-asb_scaleset", #policy doesn't work
            "ecc-azure-298-function_app_service_logging", #cannot configure via terraform or az cli
            "ecc-azure-344-mysql_threat_detection_policy", #policy doesn't work
            "ecc-azure-345-mysql_infrastructure_encryption", #policy doesn't work
            "ecc-azure-368-vmss_omi_vulnerability", #policy doesn't work
            "ecc-azure-378-cis_nsg_flow_log_analytics", #policy doesn't work
            "ecc-azure-112-cis_net_netwatcher", #cannot setup red infrastructure because of azure policy on tenant level
            "ecc-azure-141-asb_fw_traffic_route", #temporary in block
            "ecc-azure-176-asb_ddos_protection_enabled", #temporary in block
            "ecc-azure-302-redis_cache_disabled_public_access", #python sdk should be updated
            "ecc-azure-058-cis_aks_rbac", #cannot create red infra, screen in tg
            "ecc-azure-235-asb_k8s_policy", #issue with rule, should be fixed
            "ecc-azure-281-aks_non_vulnerable_version", #cannot create red tf because azure restrict to deploy new aks with vulnerable version
            "ecc-azure-038-cis_log_keyvaults", # policy and tf works but "Azure Policy" automatically deploys DS to keyvault
            "ecc-azure-354-acr_anonymous_pull", #issue with policy, should be reviewed and fixed
            "ecc-azure-005-cis_sec_email", #cannot create red tf simultaneously with 006, 007 red tf infra
            "ecc-azure-362-vm_without_va_extension" #cannot create create red tf simultaneously with 094 red tf infra
            ],
    "not-parallel": ["subscription", "spring", "role", "monitor", "defender"],
    "sleep_before_scan": []
}