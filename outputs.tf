# Here is the full list of attributes https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/windows_virtual_machine

output "computer_name" {
  description = "The ID of the deployed virtual machine"
  value       = azurerm_windows_virtual_machine.windows_vm.computer_name
}

output "public_ip_address" {
  description = "The public IP address of the deployed virtual machine"
  value       = azurerm_windows_virtual_machine.windows_vm.public_ip_addresses
}
output "private_ip_address" {
  description = "The private IP address of the deployed virtual machine"
  value       = azurerm_windows_virtual_machine.windows_vm.private_ip_addresses
}
output "location" {
  description = "The location of the deployed virtual machine"
  value       = azurerm_windows_virtual_machine.windows_vm.location
}
output "size" {
  description = "The location of the deployed virtual machine"
  value       = azurerm_windows_virtual_machine.windows_vm.size
}
output "source_image_reference" {
  description = "The location of the deployed virtual machine"
  value       = azurerm_windows_virtual_machine.windows_vm.source_image_reference
}