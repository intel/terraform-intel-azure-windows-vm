########################
####     Intel      ####
########################

# See policies.md, we recommend  Intel Xeon 3rd Generation Scalable processors (code-named Ice Lake)
# Storage Optimized: Standard_L8s_v3, Standard_L16s_v3, Standard_L32s_v3, Standard_L48s_v3, Standard_L64s_v3, Standard_L80s_v3, 
# General Purpose: Standard_D2s_v6, Standard_D4s_v6, Standard_D8s_v6, Standard_D16s_v6, Standard_D32s_v6, Standard_D48s_v6, Standard_D64s_v6, Standard_D96s_v6, Standard_D128s_v6, 
# General Purpose TDX VM: Standard_DC2s_v3, Standard_DC4s_v3, Standard_DC8s_v3, Standard_DC16s_v3, Standard_DC24s_v3, Standard_DC32s_v3, Standard_DC48s_v3, Standard_DC1ds_v3, Standard_DC2ds_v3, Standard_DC4ds_v3, Standard_DC8ds_v3, Standard_DC16ds_v3, Standard_DC24ds_v3, Standard_DC32ds_v3, Standard_DC48ds_v3
# Memory Optimized: Standard_E2s_v6, Standard_E4s_v6, Standard_E8s_v6, Standard_E16s_v6, Standard_E32s_v6, Standard_E48s_v6, Standard_E64s_v6, Standard_E96s_v6, Standard_E128s_v6, Standard_E2ds_v6, Standard_E4ds_v6, Standard_E8ds_v6, Standard_E16ds_v6, Standard_E32ds_v6, Standard_E48ds_v6, Standard_E64ds_v6, Standard_E128_6
# See more:
# https://learn.microsoft.com/en-us/azure/virtual-machines/dv5-dsv5-series
# https://learn.microsoft.com/en-us/azure/virtual-machines/ev5-esv5-series

variable "virtual_machine_size" {
  description = "The SKU that will be configured for the provisioned virtual machine"
  type        = string
  default     = "Standard_D2s_v6"
}

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

##########################################################
####     Intel Confidential VM with TDX Variable      ####
##########################################################

variable "tdx_flag" {
  description = "Determines whether a VM is TDX Confidential Compute VM"
  type        = bool
  default     = false
}

variable "secure_boot_flag" {
  description = "Enables Secure Boot- recommended TDX Confidential Compute VM"
  type        = bool
  default     = false
}

variable "encryption_at_host_flag" {
  description = "Enables OS Disk Encryption at Host - recommended for TDX Confidential Compute VM"
  type        = bool
  default     = false
}

variable "tdxzone_flag" {
  description = "Select the zone supporting Intel Confidential Compute VMs with TDX"
  type        = bool
  default     = null
}

variable "tdxzone" {
  description = "Select the zone supporting Intel Confidential Compute VMs with TDX"
  type        = number  
  default     = null
}
########################
####     Other      ####
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

variable "azurerm_network_interface_name" {
  description = "The name of the network interface. Changing this forces a new resource to be created"
  type        = string
  default     = "nic1"
}

variable "azurerm_storage_account_name" {
  description = "The name of the storage account to be used for the boot_diagnostic"
  type        = string
  default     = null
}

variable "os_disk_name" {
  description = "The name which should be used for the internal OS disk"
  type        = string
  default     = "disk1"
}

variable "vm_name" {
  description = "The unique name of the Windows virtual machine"
  type        = string
  default     = "windows-vm"
}

variable "os_disk_caching" {
  description = "The type of caching which should be used for the internal OS disk. Possible values are 'None', 'ReadOnly' and 'ReadWrite'"
  type        = string
  default     = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  description = "The type of storage account which should back this the internal OS disk. Possible values include Standard_LRS, StandardSSD_LRS and Premium_LRS"
  type        = string
  default     = "Premium_LRS"
}

variable "source_image_reference_offer" {
  description = " Specifies the offer of the image used to create the virtual machine"
  type        = string
  default     = "WindowsServer"
}

variable "source_image_reference_sku" {
  description = "Specifies the SKU of the image used to create the virtual machine"
  type        = string
  default     = "2022-Datacenter"
}

variable "source_image_reference_publisher" {
  description = "Specifies the publisher of the image used to create the virtual machine"
  type        = string
  default     = "MicrosoftWindowsServer"
}

variable "source_image_reference_version" {
  description = "Specifies the version of the image used to create the virtual machine"
  type        = string
  default     = "latest"
}

variable "ip_configuration_name" {
  description = "A name for the IP with the network interface configuration"
  type        = string
  default     = "internal"
}

variable "ip_configuration_public_ip_address_id" {
  description = "Reference to a public IP address for the NIC"
  type        = string
  default     = null
}

variable "ip_configuration_private_ip_address_allocation" {
  description = "The allocation method used for the private IP address. Possible values are Dynamic and Static"
  type        = string
  default     = "Dynamic"
  #Dynamic means "An IP is automatically assigned during creation of this Network Interface"; Static means "User supplied IP address will be used"
}


variable "admin_username" {
  description = "The username of the local administrator used for the virtual machine"
  type        = string
  default     = "adminuser"
}

variable "route_tables_ids" {
  description = "A map of subnet name for the route table ids"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(any)
  default = {
  }
}

variable "write_accelerator_enabled" {
  description = "Should write accelerator be enabled for this OS disk? Defaults to false"
  type        = bool
  default     = false
}

variable "disk_size_gb" {
  description = "The size of the internal OS disk in GB, if you wish to vary from the size used in the image this virtual machine is sourced from"
  type        = string
  default     = null
}

variable "priority" {
  description = "Specifies the priority of this virtual machine. Possible values are Regular and Spot. Defaults to Regular"
  type        = string
  default     = "Regular"
}
