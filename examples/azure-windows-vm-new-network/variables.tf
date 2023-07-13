########################
####    Required    ####
########################

variable "admin_password" {
  description = "The Password which should be used for the local-administrator on this virtual machine"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.admin_password) >= 8
    error_message = "The admin_password value must be at least 8 characters in length"
  }
}

########################
####    Other    ####
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

variable "resource_group_name" {
  description = "Name of the resource group to be imported"
  type        = string
  default     = "resoure_group_test"
}
