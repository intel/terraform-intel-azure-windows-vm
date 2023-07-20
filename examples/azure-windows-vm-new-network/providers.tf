#Terraform provider requirements and versions
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.62"
    }
  }
}

provider "azurerm" {
  features {}
}