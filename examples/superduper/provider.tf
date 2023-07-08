## Configuring the terraform and azure cloud provider
terraform {
  required_version = ">=0.12"
    required_providers {
      azurerm = {
        source = "hashicorp/azurerm"
        version = "~>3.0"
    }
  }
 }

## Configure the Microsoft Azure Provider
provider "azurerm" {
  client_id         = var.client_id
  tenant_id         = var.tenant_id
  subscription_id   = var.subscription_id
  client_secret     = var.client_secret
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    virtual_machine {
      delete_os_disk_on_deletion     = true
      graceful_shutdown              = false
      skip_shutdown_and_force_delete = false
    }
  }
}