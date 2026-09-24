terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_deleted_hardware_security_modules_on_destroy = true
    }
  }
}