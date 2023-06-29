## resource group and network information
output "resource_group_name" {
  description = "name of the resource group"
  value       = azurerm_resource_group.resourcegroup.name
}

output "resource_group_location" {
  description = "location of the resource group"
  value       = azurerm_resource_group.resourcegroup.location
}

output "subnet_id" {
  description = "subnet ID of vnet"
  value       = azurerm_subnet.subnet.id
}

## client information
output "client_external_ip" {
  description = "client external IP address for instances"
  value       = azurerm_public_ip.clientpublicip.ip_address
}

output "client_internal_ip" {
  description = "client internal IP address for instances"
  value       = azurerm_network_interface.clientnic.private_ip_address
}

output "client_nic_id" {
  description = "network interface card(NIC) of vnet for client"
  value       = azurerm_network_interface.clientnic.id
}

## server information
output "server_external_ip" {
  description = "server external IP address for instances"
  value       = azurerm_public_ip.serverpublicip.ip_address
}

output "server_internal_ip" {
  description = "server internal IP address for instances"
  value       = azurerm_network_interface.servernic.private_ip_address
}

output "server_nic_id" {
  description = "network interface card(NIC) of vnet for server"
  value       = azurerm_network_interface.servernic.id
}