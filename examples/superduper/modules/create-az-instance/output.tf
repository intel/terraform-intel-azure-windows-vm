## client output
output "client_name" {
  description = "name of client vm instance"
  value       =  azurerm_windows_virtual_machine.client.name
}

## server output
output "server_name" {
  description = "name of server vm instance"
  value       = azurerm_windows_virtual_machine.server.name
}

output "data_disk_id" {
  value = azurerm_virtual_machine_data_disk_attachment.attach_remote_data_disk.*.lun
}

output "log_disk_id" {
  value = azurerm_virtual_machine_data_disk_attachment.attach_remote_log_disk.*.lun
}

output "temp_disk_id" {
  value = azurerm_virtual_machine_data_disk_attachment.attach_remote_temp_disk.*.lun
}