## client output
output "client_external_ip" {
  description = "client external IP address of vm instance"
  value       = module.az_nic.client_external_ip
}

output "client_internal_ip" {
  description = "client internal IP address of vm instance"
  value       = module.az_nic.client_internal_ip
}

output "client_name" {
  description = "name of client vm instance"
  value       =  module.az_vm_instance.client_name
}

## server output
output "server_external_ip" {
  description = "server external IP address of vm instance"
  value       = module.az_nic.server_external_ip
}

output "server_internal_ip" {
  description = "server internal IP address of vm instance"
  value       = module.az_nic.server_internal_ip
}

output "server_name" {
  description = "name of server vm instance"
  value       = module.az_vm_instance.server_name
}

output "data_disk_volume_id" {
  description = "data disk volume id"
  value       = module.az_vm_instance.data_disk_id
}

output "log_disk_volume_id" {
  description = "log disk volume id"
  value       = module.az_vm_instance.log_disk_id
}

output "temp_disk_volume_id" {
  description = "tempdb disk volume id"
  value       = module.az_vm_instance.temp_disk_id
}