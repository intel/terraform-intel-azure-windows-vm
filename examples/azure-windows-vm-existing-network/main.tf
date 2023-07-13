###  required, resource group, subnet_name, virtual_network_name
// TODO - update required section with reference to terraform.tfvars file for the 3 fields needed. 

module "azure-windows-vm" {
  source                       = "intel/azure-windows-vm/intel"
  admin_password               = var.admin_password
  azurerm_resource_group_name  = var.azurerm_resource_group_name
  azurerm_subnet_name          = var.azurerm_subnet_name
  azurerm_virtual_network_name = var.azurerm_virtual_network_name
  tags = {
    owner    = "owner_josh",
    duration = "5"
  }
}

