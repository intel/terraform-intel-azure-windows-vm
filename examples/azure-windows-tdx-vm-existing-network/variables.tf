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
#During public preview you may need to speicfy zone due to availablity of TDX VMs in some zones only, currenlty default zone is 3 for eastus2 region
variable "tdxzone" {
  description = "Select the zone supporting Intel Confidential Compute VMs with TDX"
  type        = number  
  default     = 3
}