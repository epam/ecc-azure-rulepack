aws = {}

gcp = {}

azure = {
    "green": ["ecc-azure-109-cis_sa_logging_blob",
              "ecc-azure-110-cis_sa_logging_table",
              "ecc-azure-069-cis_app_last_java",
              "ecc-azure-071-cis_app_last_php",
              "ecc-azure-072-cis-app-keyvaults"], #policy doesn't work
    "red": ["ecc-azure-105-cis_sa_keys_regen"],
    "not-parallel": [],
    "sleep_before_scan": []
}