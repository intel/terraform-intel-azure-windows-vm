<p align="center">
  <img src="https://github.com/intel/terraform-intel-azure-windows-vm/blob/main/images/logo-classicblue-800px.png?raw=true" alt="Intel Logo" width="250"/>
</p>

# Intel® Optimized Cloud Modules for Terraform

© Copyright 2024, Intel Corporation

## Azure Windows Virtual Machine

Azure Windows Virtual Machine

## Terraform Intel Azure VM - Windows VM
This example creates an Azure Virtual Machine on Intel® 5th Generation Xeon® Scalable Emerald Rapids on Windows Operating System. The virtual machine is created on an Intel Emerald Rapids  Standard_D2s_v6 by default using "2022-Datacenter-g2" # Generation 2 SKU.  This module will create the Azure Resources needed to provision an instance. 

As you configure your application's environment, choose the configurations for your infrastructure that matches your application's requirements. In this example, the virtual machine is using a **newly configured network interface, subnet, and resource group** and has an additional option to enable boot diagnostics. The tags Name, Owner and Duration are added to the virtual machine when it is created.

## Usage

See examples folder for code ./examples/azure-windows-vm/main.tf


# Provision Intel Cloud Optimization Module

variables.tf
```hcl
variable "admin_password" {
  description = "The Password which should be used for the local-administrator on this virtual machine"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.admin_password) >= 8
    error_message = "The admin_password value must be at least 8 characters in length"
  }
}
```

main.tf

**NOTE:** Locals block is where you can change the **name and location** of the resource group being created for  the Azure Windows VM
```hcl
locals{
  resource_group_name = "resource-group-test"
  location            = "West US 2"
}

# Creation of Azure Resource Group, network interface, subnet

resource "azurerm_resource_group" "example" {
  name     = local.resource_group_name
  location = local.location
}

resource "azurerm_virtual_network" "example" {
  name                = "${var.prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "${var.prefix}-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "example" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "${var.prefix}-nic-config"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

#Creation of the Windows-VM

module "azure-windows-vm" {
  source                       = "intel/azure-windows-vm/intel"
  admin_password               = var.admin_password
  azurerm_resource_group_name  = azurerm_resource_group.example.name
  azurerm_subnet_name          = azurerm_subnet.example.name
  azurerm_virtual_network_name = azurerm_virtual_network.example.name
  tags = {
    owner    = "owner_name",
    duration = "5"
  }
  depends_on = [azurerm_resource_group.example]
}



```


Run Terraform

```hcl
terraform init  
terraform plan
terraform apply
```
```hcl
# Example of how to pass variable for virtual machine password:
# terraform apply -var="admin_password=..."
# Environment variables can also be used https://www.terraform.io/language/values/variables#environment-variables
```

Note that this example may create resources. Run `terraform destroy` when you don't need these resources anymore.

## Considerations  

```hcl

When admin_password is specified disable_password_authentication must be set to false.

Either admin_password or admin_ssh_key must be specified.

The virtual machine is using a newly created network interface, subnet, and resource group that was created before the creartion of Windows VM. See main.tf for implementation details

```

