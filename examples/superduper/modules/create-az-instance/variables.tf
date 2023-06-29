variable "name" {}
variable "account_name" {}
variable "unique_id" {}

## NIC information
variable "resource_group_name" {}
variable "region" {}

## VM information
 ## --- client information
variable "client_publisher" {}
variable "client_offer" {}
variable "client_vm_size" {}
variable "client_sku" {}
variable "client_storage_account_type" {}
variable "client_network_interface_ids" {}
 ## --- server information
variable "server_publisher" {}
variable "server_offer" {}
variable "server_machine_type" {}
variable "server_sku" {}
variable "server_disk_type" {}
variable "server_network_interface_ids" {}
 ## --- other information
variable "sir_version" {}
variable "caching" {}
variable "create_option" {}
variable "computer_name" {}
variable "admin_username" {}
variable "admin_password" {}
# variable "disable_password_authentication" {}
 ## --- disk information for server
variable "remote_data_storage_num" {}
variable "remote_data_storage_type" {}
variable "remote_data_disk_create_option" {}
variable "remote_data_storage_size" {}
variable "remote_data_storage_lun" {}
variable "remote_data_storage_caching" {}

variable "remote_log_storage_num" {}
variable "remote_log_storage_type" {}
variable "remote_log_disk_create_option" {}
variable "remote_log_storage_size" {}
variable "remote_log_storage_lun" {}
variable "remote_log_storage_caching" {}

variable "remote_temp_storage_num" {}
variable "remote_temp_storage_type" {}
variable "remote_temp_disk_create_option" {}
variable "remote_temp_storage_size" {}
variable "remote_temp_storage_lun" {}
variable "remote_temp_storage_caching" {}