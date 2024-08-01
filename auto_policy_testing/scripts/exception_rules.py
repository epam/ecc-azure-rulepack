aws = {}

gcp = {}

azure = {
    "green": ["ecc-azure-109-cis_sa_logging_blob", #cannot configure via terraform or az cli
              "ecc-azure-152-asb_vm_jit_port_protection", #cannot configure via terraform or az cli
              "ecc-azure-172-asb_mysql_private_endpoint", #policy doesn`t work because of old api
              "ecc-azure-110-cis_sa_logging_table", #cannot configure via terraform or az cli
              "ecc-azure-197-asb_vm_disk_encryption_on", #policy doesn't work
              "ecc-azure-227-asb_reslogs_vmss", #policy doesn't work
              "ecc-azure-272-asb_scaleset", #policy doesn't work
              "ecc-azure-344-mysql_threat_detection_policy", #policy doesn't work
              "ecc-azure-345-mysql_infrastructure_encryption", #policy doesn't work
              "ecc-azure-368-vmss_omi_vulnerability", #policy doesn't work
              "ecc-azure-378-cis_nsg_flow_log_analytics", #policy doesn't work
              "ecc-azure-201-asb_cosmosdb_encrypt_cmk", #policy work but need additional permissions
              "ecc-azure-203-asb_postgresql_encrypt_cmk" #policy work but terraform destroy fails pipeline
              ], 
    "red": ["ecc-azure-105-cis_sa_keys_regen", #cannot configure via terraform or az cli
            "ecc-azure-157-asb_mysql_public_access_disabled", #cannot configure via terraform or az cli
            "ecc-azure-172-asb_mysql_private_endpoint", #policy doesn`t work because of old api
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
            "ecc-azure-176-asb_ddos_protection_enabled" #temporary in block
            ],
    "not-parallel": ["subscription"],
    "sleep_before_scan": []
}