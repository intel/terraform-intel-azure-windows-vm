<p align="center">
  <img src="https://github.com/intel/terraform-intel-azure-windows-vm/blob/main/images/logo-classicblue-800px.png?raw=true" alt="Intel Logo" width="250"/>
</p>

# Intel® Optimized Cloud Modules for Terraform

© Copyright 2025, Intel Corporation

## Azure Windows Virtual Machine

Azure Windows Virtual Machine

## Terraform Intel Azure VM - Windows VM
This example creates an Azure Virtual Machine on Intel® 5th Generation Xeon® Scalable Emerald Rapids (for Intel Non-TDX VMs) and Intel® 4th Generation Xeon® Sapphire Rapids CPUs (for Intel Confidential Compute VMs with Intel TDX)  using "2022-Datacenter-g2" # Generation 2 SKU Windows Operating System.

The virtual machine is created on an Intel Emerald Rapids (EMR) Standard_D2_v6 by default and if using Intel Confidential Computing VMs with Intel TDX the default will be Intel Sapphire Rapids Standard_DC2es_v5 (EMR not yet available with TDX in Azure).

As you configure your application's environment, choose the configurations for your infrastructure that matches your application's requirements. 

In this example, the virtual machine is using a preconfigured network interface, subnet, and resource group. 

The tags Name, Owner and Duration are added to the virtual machine when it is created.

We have now included example for provisioning Intel Confidential VMs with TDX- see "azure-windows-tdx-vm-existing-network" example folder.

## Performance Data 

<center>

#### Find all the information below plus even more by navigating our full library
#### [INTEL CLOUD PERFORMANCE DATA LIBRARY for Azure](https://www.intel.com/content/www/us/en/developer/topic-technology/cloud/library.html?q=azure&s=Relevancy)

**NOTE: Intel Emerald Rapids (Intel 5th Generation Scalable Processor) Performance Data for Azure is not yet available and will be coming soon.**
#

#### [Handle up to 1.53x as Many WordPress Users on Microsoft® Azure®  Ddsv5 Virtual Machines as on Ddsv4 VMs](https://www.intel.com/content/www/us/en/content-details/767772/handle-up-to-1-53x-as-many-wordpress-users-on-microsoft-azure-ddsv5-virtual-machines-as-on-ddsv4-vms.html)

<p align="center">
  <a href="https://www.intel.com/content/www/us/en/content-details/767772/handle-up-to-1-53x-as-many-wordpress-users-on-microsoft-azure-ddsv5-virtual-machines-as-on-ddsv4-vms.html">
  <img src="https://github.com/intel/terraform-intel-azure-windows-vm/blob/main/images/azure-vm-wordpress.JPG?raw=true" alt="Link" width="600"/>
  </a>
</p>


#

#### [To Complete Artificial Intelligence Workloads Faster, Choose Microsoft Azure Edsv5-Series VMs Featuring 3rd Gen Intel® Xeon® Scalable Processors](https://www.intel.com/content/www/us/en/content-details/780282/to-complete-artificial-intelligence-workloads-faster-choose-microsoft-azure-edsv5-series-vms-featuring-3rd-gen-intel-xeon-scalable-processors.html)

<p align="center">
  <a href="https://www.intel.com/content/www/us/en/content-details/780282/to-complete-artificial-intelligence-workloads-faster-choose-microsoft-azure-edsv5-series-vms-featuring-3rd-gen-intel-xeon-scalable-processors.html">
  <img src="https://github.com/intel/terraform-intel-azure-windows-vm/blob/main/images/azure-vm-ai.jpg?raw=true" alt="Link" width="600"/>
  </a>
</p>


#

#### [Handle up to 69 Percent More ASP.NET Work on Microsoft® Azure® Dsv5 Virtual Machines Featuring 3rd Gen Intel®  Xeon® Scalable Processors](https://www.intel.com/content/www/us/en/content-details/756595/intel-azure-proof-points-better-asp-net-performance-on-3rd-gen-intel-xeon-instances.html)

<p align="center">
  <a href="https://www.intel.com/content/www/us/en/content-details/756595/intel-azure-proof-points-better-asp-net-performance-on-3rd-gen-intel-xeon-instances.html">
  <img src="https://github.com/intel/terraform-intel-azure-windows-vm/blob/main/images/azure-vm-asp.jpg?raw=true" alt="Link" width="600"/>
  </a>
</p>


#

#### [Process up to 35% More MySQL New Orders per Minute on Microsoft Azure MVs Featuring 3rd Gen Intel Xeon Scalable Processors with 16 vCPUs](https://www.intel.com/content/www/us/en/content-details/754003/process-up-to-35-more-mysql-new-orders-per-minute-on-microsoft-azure-mvs-featuring-3rd-gen-intel-xeon-scalable-processors-with-16-vcpus.html)

<p align="center">
  <a href="https://www.intel.com/content/www/us/en/content-details/754003/process-up-to-35-more-mysql-new-orders-per-minute-on-microsoft-azure-mvs-featuring-3rd-gen-intel-xeon-scalable-processors-with-16-vcpus.html">
  <img src="https://github.com/intel/terraform-intel-azure-windows-vm/blob/main/images/azure-vm-mysql.JPG?raw=true" alt="Link" width="600"/>
  </a>
</p>


#


#### [Boost MariaDB Performance by up to 1.40x with Microsoft Azure Edsv5 Virtual Machines vs. EDSV4 VMs](https://www.intel.com/content/www/us/en/content-details/755218/boost-mariadb-performance-by-up-to-1-40x-with-microsoft-azure-edsv5-virtual-machines-vs-edsv4-vms.html)

<p align="center">
  <a href="https://www.intel.com/content/www/us/en/content-details/755218/boost-mariadb-performance-by-up-to-1-40x-with-microsoft-azure-edsv5-virtual-machines-vs-edsv4-vms.html">
  <img src="https://github.com/intel/terraform-intel-azure-windows-vm/blob/main/images/azure-vm-mariadb.JPG?raw=true" alt="Link" width="600"/>
  </a>
</p>


#
</center>


## Usage

See examples folder for code ./examples/azure-windows-vm/main.tf

Example of main.tf

```hcl
# Example of how to pass variable for virtual machine password:
# terraform apply -var="admin_password=..."
# Environment variables can also be used https://www.terraform.io/language/values/variables#environment-variables
```
# Provision Intel Cloud Optimization Module

variables.tf
```hcl
variable "admin_password" {
  type        = string
  default     = null
  sensitive   = true
}
```

main.tf
```hcl

module "azure-vm" {
  source                = "intel/azure-linux-vm/intel"
  azurerm_resource_group_name         = "example_resource_group"
  virtual_network_resource_group_name = "vnet_example_resource_group"
  azurerm_virtual_network_name        = "example_virtual_network_name"
  azurerm_network_interface_name      = "example_network_interface"
  admin_password                      = var.admin_password
}

```


Run Terraform

```hcl
terraform init  
terraform plan
terraform apply
```

Note that this example may create resources. Run `terraform destroy` when you don't need these resources anymore.

## Considerations  
- Using HashiCorp Modules alongside green-blue deployment allows for a secure and efficient deployment process. The modules can be easily integrated into both the active and inactive environments, ensuring consistency across both environments.
   - Instance - If you swap the instances terraform apply will shut down immediately, destroy and create a new instance which will incur service interruption.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.41.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>3.41.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine.linux_vm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine) | resource |
| [azurerm_network_interface.nic](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_storage_account.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/storage_account) | data source |
| [azurerm_subnet.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The Password which should be used for the local-administrator on this virtual machine | `string` | n/a | yes |
| <a name="input_admin_ssh_key"></a> [admin\_ssh\_key](#input\_admin\_ssh\_key) | n/a | `list(any)` | `[]` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The username of the local administrator used for the virtual machine | `string` | `"adminuser"` | no |
| <a name="input_azurerm_network_interface_name"></a> [azurerm\_network\_interface\_name](#input\_azurerm\_network\_interface\_name) | The name of the network interface. Changing this forces a new resource to be created | `string` | `"nic1"` | no |
| <a name="input_azurerm_resource_group_name"></a> [azurerm\_resource\_group\_name](#input\_azurerm\_resource\_group\_name) | Name of the resource group to be imported | `string` | n/a | yes |
| <a name="input_azurerm_storage_account_name"></a> [azurerm\_storage\_account\_name](#input\_azurerm\_storage\_account\_name) | The name of the storage account to be used for the boot\_diagnostic | `string` | `null` | no |
| <a name="input_azurerm_subnet_name"></a> [azurerm\_subnet\_name](#input\_azurerm\_subnet\_name) | The name of the preconfigured subnet | `string` | n/a | yes |
| <a name="input_azurerm_virtual_network_name"></a> [azurerm\_virtual\_network\_name](#input\_azurerm\_virtual\_network\_name) | Name of the preconfigured virtual network | `string` | n/a | yes |
| <a name="input_disable_password_authentication"></a> [disable\_password\_authentication](#input\_disable\_password\_authentication) | Boolean that determines if password authentication will be disabled on this virtual machine | `bool` | `false` | no |
| <a name="input_disk_size_gb"></a> [disk\_size\_gb](#input\_disk\_size\_gb) | The size of the internal OS disk in GB, if you wish to vary from the size used in the image this virtual machine is sourced from | `string` | `null` | no |
| <a name="input_enable_boot_diagnostics"></a> [enable\_boot\_diagnostics](#input\_enable\_boot\_diagnostics) | Boolean that determines if the boot diagnostics will be enabled on this virtual machine | `bool` | `true` | no |
| <a name="input_eviction_policy"></a> [eviction\_policy](#input\_eviction\_policy) | Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance. Possible values are Deallocate and Delete | `string` | `"Deallocate"` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | n/a | <pre>object({<br>    identity_ids = optional(list(string))<br>    principal_id = optional(string)<br>    tentant_id   = optional(string)<br>    type         = optional(string, "SystemAssigned")<br>  })</pre> | `{}` | no |
| <a name="input_ip_configuration_name"></a> [ip\_configuration\_name](#input\_ip\_configuration\_name) | A name for the IP with the network interface configuration | `string` | `"internal"` | no |
| <a name="input_ip_configuration_private_ip_address_allocation"></a> [ip\_configuration\_private\_ip\_address\_allocation](#input\_ip\_configuration\_private\_ip\_address\_allocation) | The allocation method used for the private IP address. Possible values are Dynamic and Static | `string` | `"Dynamic"` | no |
| <a name="input_ip_configuration_public_ip_address_id"></a> [ip\_configuration\_public\_ip\_address\_id](#input\_ip\_configuration\_public\_ip\_address\_id) | Reference to a public IP address for the NIC | `string` | `null` | no |
| <a name="input_max_bid_price"></a> [max\_bid\_price](#input\_max\_bid\_price) | The maximum price you're willing to pay for this virtual machine, in US Dollars; which must be greater than the current spot price. If this bid price falls below the current spot price the virtual machine will be evicted using the eviction\_policy | `string` | `"-1"` | no |
| <a name="input_os_disk_caching"></a> [os\_disk\_caching](#input\_os\_disk\_caching) | The type of caching which should be used for the internal OS disk. Possible values are 'None', 'ReadOnly' and 'ReadWrite' | `string` | `"ReadWrite"` | no |
| <a name="input_os_disk_name"></a> [os\_disk\_name](#input\_os\_disk\_name) | The name which should be used for the internal OS disk | `string` | `"disk1"` | no |
| <a name="input_os_disk_storage_account_type"></a> [os\_disk\_storage\_account\_type](#input\_os\_disk\_storage\_account\_type) | The type of storage account which should back this the internal OS disk. Possible values include Standard\_LRS, StandardSSD\_LRS and Premium\_LRS | `string` | `"Premium_LRS"` | no |
| <a name="input_priority"></a> [priority](#input\_priority) | Specifies the priority of this virtual machine. Possible values are Regular and Spot. Defaults to Regular | `string` | `"Regular"` | no |
| <a name="input_route_tables_ids"></a> [route\_tables\_ids](#input\_route\_tables\_ids) | A map of subnet name for the route table ids | `map(string)` | `{}` | no |
| <a name="input_source_image_reference_offer"></a> [source\_image\_reference\_offer](#input\_source\_image\_reference\_offer) | Specifies the offer of the image used to create the virtual machine | `string` | `"0001-com-ubuntu-server-jammy"` | no |
| <a name="input_source_image_reference_publisher"></a> [source\_image\_reference\_publisher](#input\_source\_image\_reference\_publisher) | Specifies the publisher of the image used to create the virtual machine | `string` | `"Canonical"` | no |
| <a name="input_source_image_reference_sku"></a> [source\_image\_reference\_sku](#input\_source\_image\_reference\_sku) | Specifies the SKU of the image used to create the virtual machine | `string` | `"22_04-lts-gen2"` | no |
| <a name="input_source_image_reference_version"></a> [source\_image\_reference\_version](#input\_source\_image\_reference\_version) | Specifies the version of the image used to create the virtual machine | `string` | `"latest"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to the resource | `map(any)` | `{}` | no |
| <a name="input_virtual_machine_size"></a> [virtual\_machine\_size](#input\_virtual\_machine\_size) | The SKU that will be configured for the provisioned virtual machine | `string` | `"Standard_D2s_v5"` | no |
| <a name="input_virtual_network_resource_group_name"></a> [virtual\_network\_resource\_group\_name](#input\_virtual\_network\_resource\_group\_name) | Name of the resource group of the virtual network | `string` | n/a | yes |
| <a name="input_vm_name"></a> [vm\_name](#input\_vm\_name) | The unique name of the Linux virtual machine | `string` | `"vm1"` | no |
| <a name="input_write_accelerator_enabled"></a> [write\_accelerator\_enabled](#input\_write\_accelerator\_enabled) | Should write accelerator be enabled for this OS disk? Defaults to false | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_username"></a> [admin\_username](#output\_admin\_username) | Virtual machine admin username |
| <a name="output_identity"></a> [identity](#output\_identity) | Identity configuration associated with the virtual machine |
| <a name="output_location"></a> [location](#output\_location) | Location where the virtual machine will be created |
| <a name="output_name"></a> [name](#output\_name) | Virtual machine name |
| <a name="output_network_interface_ids"></a> [network\_interface\_ids](#output\_network\_interface\_ids) | List of network interface IDs that are attached to the virtual machine |
| <a name="output_os_disk"></a> [os\_disk](#output\_os\_disk) | Disk properties that are attached to the virtual machine |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | Name of the resource group |
| <a name="output_size"></a> [size](#output\_size) | The SKU for the virtual machine |
| <a name="output_storage_account_tier"></a> [storage\_account\_tier](#output\_storage\_account\_tier) | Tier to identify the storage account associated with the virtual machine |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags that are assigned to the virtual machine |
| <a name="output_virtual_machine_id"></a> [virtual\_machine\_id](#output\_virtual\_machine\_id) | ID assigned to the virtual machine after it has been created |

## Links
https://azure.microsoft.com/en-us/products/virtual-machines/linux/
<!-- END_TF_DOCS -->