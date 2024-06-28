aws = {}

gcp = {}

azure = {
    "green": ["ecc-azure-109-cis_sa_logging_blob",
              "ecc-azure-110-cis_sa_logging_table",
              "ecc-azure-069-cis_app_last_java",
              "ecc-azure-071-cis_app_last_php",
              "ecc-azure-072-cis-app-keyvaults", #policy doesn't work
              "ecc-azure-378-cis_nsg_flow_log_analytics" #policy doesn't work
              ], 
    "red": ["ecc-azure-105-cis_sa_keys_regen",
            "ecc-azure-267-asb_java_funcapp",
            "ecc-azure-298-function_app_service_logging", #cannot configure via terraform or az cli
            "ecc-azure-179-asb_app_service_managed_identity", #api app deprecated
            "ecc-azure-236-asb_cors_api", #api app deprecated
            "ecc-azure-239-asb_certif_api", #api app deprecated
            "ecc-azure-256-asb_remotedebug_api", #api app deprecated
            "ecc-azure-258-asb_remotedebug_web", #terraform or azure policy issue
            "ecc-azure-378-cis_nsg_flow_log_analytics" #policy doesn't work
            ],
    "not-parallel": [],
    "sleep_before_scan": []
}