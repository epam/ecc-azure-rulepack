terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

resource "azurerm_resource_group" "this" {
  name     = "${var.prefix}-rg-green"
  location = var.location

  tags = var.tags
}

data "azurerm_client_config" "current" {}