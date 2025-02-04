terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4"
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

