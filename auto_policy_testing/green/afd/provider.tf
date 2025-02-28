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
  features {}
}