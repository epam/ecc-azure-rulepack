aws = {}

gcp = {}

azure = {
    "green": ["ecc-azure-109-cis_sa_logging_blob", #cannot configure via terraform or az cli
              "ecc-azure-110-cis_sa_logging_table", #cannot configure via terraform or az cli
              "ecc-azure-069-cis_app_last_java", #will try
              "ecc-azure-071-cis_app_last_php", #will try
              "ecc-azure-197-asb_vm_disk_encryption_on", #policy doesn't work
              "ecc-azure-227-asb_reslogs_vmss", #policy doesn't work
              "ecc-azure-272-asb_scaleset", #policy doesn't work
              "ecc-azure-368-vmss_omi_vulnerability", #policy doesn't work
              "ecc-azure-378-cis_nsg_flow_log_analytics" #policy doesn't work
              ], 
    "red": ["ecc-azure-105-cis_sa_keys_regen", #cannot configure via terraform or az cli
            "ecc-azure-197-asb_vm_disk_encryption_on", #policy doesn't work
            "ecc-azure-227-asb_reslogs_vmss", #policy doesn't work
            "ecc-azure-272-asb_scaleset", #policy doesn't work
            "ecc-azure-298-function_app_service_logging", #cannot configure via terraform or az cli
            "ecc-azure-368-vmss_omi_vulnerability", #policy doesn't work
            "ecc-azure-378-cis_nsg_flow_log_analytics" #policy doesn't work
            ],
    "not-parallel": [],
    "sleep_before_scan": []
}