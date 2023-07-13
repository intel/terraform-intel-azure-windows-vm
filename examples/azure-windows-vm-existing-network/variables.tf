########################
####    Required    ####
########################
variable "prefix" {
  description = "landing zone usage - testing, qa, prod"
  type        = string
  default     = "testing"
}

variable "location" {
  description = "region where the instance will land"
  type        = string
  default     = "West US 2"
}

variable "admin_password" {
  description = "The Password which should be used for the local-administrator on this virtual machine"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.admin_password) >= 8
    error_message = "The admin_password value must be at least 8 characters in length"
  }
}

variable "azurerm_virtual_network_name" {
  description = "Name of the preconfigured virtual network"
  type        = string
}

variable "azurerm_resource_group_name" {
  description = "Name of the resource group to be imported"
  type        = string
}

variable "azurerm_subnet_name" {
  description = "The name of the preconfigured subnet"
  type        = string
}
