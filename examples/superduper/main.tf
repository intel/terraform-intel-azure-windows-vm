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

module "random_id" {
  source = "./modules/create-random-id"
}

module "az_nic" {
  source                          = "./modules/create-az-nic"
  name                            = var.name
  region                          = var.location
  private_ip_address_allocation   = var.private_ip_address_allocation
  account_name                    = var.account_name
  address_space                   = var.address_space
  address_prefixes                = var.address_prefixes
  allocation_method               = var.allocation_method
  idle_timeout_in_minutes         = var.idle_timeout_in_minutes
  priority                        = var.priority
  direction                       = var.direction
  access                          = var.access
  protocol_tcp                    = var.protocol_tcp
  protocol_udp                    = var.protocol_udp
  source_port_range               = var.source_port_range
  source_address_prefixes         = var.source_address_prefixes
  destination_address_prefix      = var.destination_address_prefix
  destination_tcpport_ranges      = var.destination_tcpport_ranges
  destination_udpport_ranges      = var.destination_udpport_ranges
  unique_id                       = module.random_id.unique_id
}

module "az_vm_instance" {
  source                          = "./modules/create-az-instance"
  name                            = var.name
  account_name                    = var.account_name
  client_publisher                = var.client_publisher
  client_offer                    = var.client_offer
  client_vm_size                  = var.client_vm_size
  client_sku                      = var.client_sku
  client_storage_account_type     = var.client_storage_account_type
  server_publisher                = var.server_publisher
  server_offer                    = var.server_offer
  server_machine_type             = var.server_machine_type
  server_sku                      = var.server_sku
  server_disk_type                = var.server_disk_type
  sir_version                     = var.sir_version
  caching                         = var.caching
  create_option                   = var.create_option
  computer_name                   = var.computer_name
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  # disable_password_authentication = var.disable_password_authentication
  unique_id                       = module.random_id.unique_id
  region                          = module.az_nic.resource_group_location
  resource_group_name             = module.az_nic.resource_group_name
  client_network_interface_ids    = module.az_nic.client_nic_id
  server_network_interface_ids    = module.az_nic.server_nic_id

  remote_data_storage_num         = var.remote_data_storage_num
  remote_data_storage_type        = var.remote_data_storage_type
  remote_data_disk_create_option  = var.remote_data_disk_create_option
  remote_data_storage_size        = var.remote_data_storage_size
  remote_data_storage_lun         = var.remote_data_storage_lun
  remote_data_storage_caching     = var.remote_data_storage_caching

  remote_log_storage_num          = var.remote_log_storage_num
  remote_log_storage_type         = var.remote_log_storage_type
  remote_log_disk_create_option   = var.remote_log_disk_create_option
  remote_log_storage_size         = var.remote_log_storage_size
  remote_log_storage_lun          = var.remote_log_storage_lun
  remote_log_storage_caching      = var.remote_log_storage_caching

  remote_temp_storage_num         = var.remote_temp_storage_num
  remote_temp_storage_type        = var.remote_temp_storage_type
  remote_temp_disk_create_option  = var.remote_temp_disk_create_option
  remote_temp_storage_size        = var.remote_temp_storage_size
  remote_temp_storage_lun         = var.remote_temp_storage_lun
  remote_temp_storage_caching     = var.remote_temp_storage_caching
}