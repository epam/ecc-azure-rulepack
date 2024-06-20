aws = {}

gcp = {}

azure = {
    "green": ["ecc-azure-109-cis_sa_logging_blob",
              "ecc-azure-110-cis_sa_logging_table"],
    "red": ["ecc-azure-105-cis_sa_keys_regen"],
    "not-parallel": [],
    "sleep_before_scan": []
}