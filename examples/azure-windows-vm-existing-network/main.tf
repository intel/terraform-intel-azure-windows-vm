###  required, resource group, subnet_name, virtual_network_name
// TODO - update required section with reference to terraform.tfvars file for the 3 fields needed. 

module "azure-windows-vm" {
  #source                       = "intel/azure-windows-vm/intel"
  source                       = "../.."
  admin_password               = var.admin_password
  azurerm_resource_group_name  = "terraform-testing-rg"
  azurerm_subnet_name          = "default"
  azurerm_virtual_network_name = "vm-vnet1"
  tags = {
    owner    = "user@company.com",
    duration = "5"
  }
}

