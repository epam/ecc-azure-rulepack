aws = {}

gcp = {}

azure = {
    "green": ["ecc-azure-072-cis-app-keyvaults", #policy working, waiting for release version
              "ecc-azure-109-cis_sa_logging_blob", #cannot configure via terraform or az cli
              "ecc-azure-110-cis_sa_logging_table", #cannot configure via terraform or az cli
              "ecc-azure-197-asb_vm_disk_encryption_on", #policy doesn't work
              "ecc-azure-227-asb_reslogs_vmss", #policy doesn't work
              "ecc-azure-272-asb_scaleset", #policy doesn't work
              "ecc-azure-344-mysql_threat_detection_policy", #policy doesn't work
              "ecc-azure-345-mysql_infrastructure_encryption", #policy doesn't work
              "ecc-azure-347-mysql_cmk", # should be updated
              "ecc-azure-368-vmss_omi_vulnerability", #policy doesn't work
              "ecc-azure-378-cis_nsg_flow_log_analytics" #policy doesn't work
              ], 
    "red": ["ecc-azure-105-cis_sa_keys_regen", #cannot configure via terraform or az cli
            "ecc-azure-197-asb_vm_disk_encryption_on", #policy doesn't work
            "ecc-azure-227-asb_reslogs_vmss", #policy doesn't work
            "ecc-azure-258-asb_remotedebug_web", #terraform issue
            "ecc-azure-272-asb_scaleset", #policy doesn't work
            "ecc-azure-298-function_app_service_logging", #cannot configure via terraform or az cli
            "ecc-azure-344-mysql_threat_detection_policy", #policy doesn't work
            "ecc-azure-345-mysql_infrastructure_encryption", #policy doesn't work
            "ecc-azure-347-mysql_cmk", # should be updated
            "ecc-azure-368-vmss_omi_vulnerability", #policy doesn't work
            "ecc-azure-378-cis_nsg_flow_log_analytics" #policy doesn't work
            ],
    "not-parallel": ["sql", "mysql"],
    "sleep_before_scan": []
}