# Example of how to pass variable for database password:
# terraform apply -var="db_password=..."
# Environment variables can also be used https://www.terraform.io/language/values/variables#environment-variables
# Resource azurerm_linux_virtual_machine requires a preconfigured resource group, virtual network, and subnet in Azure - make sure the Azure region supports Intel Confidential VMs with TDX


################################################################################
# For Azure Key Vault - This is Optional
################################################################################
#data "azurerm_resource_group" "rg" {
#  name = "terraform-testing-rg"
#}

  data "azurerm_client_config" "current" {}

  resource "azurerm_key_vault" "example" {
  name                        = "tdxwinkeyvault"
  resource_group_name         = "terraform-testing-rg"
  location                    = "eastus2"
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

key_permissions = [
      "Create",
      "Delete",
      "Get",
      "Purge",
      "Recover",
      "Update",
      "GetRotationPolicy",
      "SetRotationPolicy"
    ]

    secret_permissions = [
      "Set",
    ]
    storage_permissions = [
      "Get",
    ]
  }
}

resource "azurerm_key_vault_key" "generated" {
  name         = "generated-certificate"
  key_vault_id = azurerm_key_vault.example.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  rotation_policy {
    automatic {
      time_before_expiry = "P30D"
    }

    expire_after         = "P90D"
    notify_before_expiry = "P29D"
  }
}


################################################################################
# For Azure Virtual Machine - Required
################################################################################

module "azure-windows-vm" {
  source                            = "intel/azure-windows-vm/intel"
  admin_password                    = var.admin_password
  azurerm_resource_group_name       = "terraform-testing-rg"
  azurerm_subnet_name               = "tdxsubnet"
  azurerm_virtual_network_name      = "tdxvnet"
  #Set to flag below to use Intel Confidential VM with TDX
  tdx_flag                            = true
  secure_boot_flag                    = true
  encryption_at_host_flag             = true
  #During public preview you may need to speicfy zone due to availablity of TDX VMs in some zones only, currenlty default zone is 3 for useast3 region- see variables.tf
  tdxzone_flag                        = true
  #Choose the images supporting Intel Confidential Compute VMs with Intel TDX
  virtual_machine_size              = "Standard_DC2es_v5"
  source_image_reference_publisher  = "MicrosoftWindowsServer" 
  source_image_reference_offer      = "WindowsServer"
  source_image_reference_sku        = "2022-Datacenter-g2"
  source_image_reference_version    = "latest"
    tags = {
    "owner"    = "user@company.com"
    "duration" = "1"
  }
}   
 
