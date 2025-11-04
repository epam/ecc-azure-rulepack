terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4"
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
    machine_learning {
      purge_soft_deleted_workspace_on_destroy = true
    }
  }
}

