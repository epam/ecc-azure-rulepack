terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = ""
    key    = ""
    region = ""
  }

}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy       = true
      purge_soft_deleted_keys_on_destroy = true
      purge_soft_deleted_secrets_on_destroy = true
    }

    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}