variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region where the resource group should be created."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "address_space" {
  description = "The address space for the virtual network."
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_name" {
  description = "The name of the subnet."
  type        = string
}

variable "subnet_address_prefix" {
  description = "The address prefix for the subnet."
  type        = string
  default     = "10.0.1.0/24"
}
