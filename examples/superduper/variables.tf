variable "name" {}
variable "account_name" {}

variable "client_id" {}
variable "tenant_id" {}
variable "subscription_id" {}
variable "client_secret" {}

## NIC information
variable "location" {}
variable "private_ip_address_allocation" {}
variable "address_space" {}
variable "address_prefixes" {}
variable "allocation_method" {}
variable "idle_timeout_in_minutes" {}

## security rule
variable "priority" {}
variable "direction" {}
variable "access" {}
variable "protocol_tcp" {}
variable "protocol_udp" {}
variable "source_port_range" {}
variable "source_address_prefixes" {}
variable "destination_address_prefix" {}
variable "destination_tcpport_ranges" {}
variable "destination_udpport_ranges" {}

## VM information
 ## --- client information
variable "client_publisher" {}
variable "client_offer" {}
variable "client_vm_size" {} # client boot disk size
variable "client_sku" {}
variable "client_storage_account_type" {}
 ## --- server information
variable "server_publisher" {}
variable "server_offer" {}
variable "server_machine_type" {} # server boot disk size
variable "server_sku" {}
variable "server_disk_type" {}
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