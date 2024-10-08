terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    
    azapi = {
      source = "Azure/azapi"
    }

  }
}

provider "azapi" {
}

provider "azurerm" {
  features {}
}

