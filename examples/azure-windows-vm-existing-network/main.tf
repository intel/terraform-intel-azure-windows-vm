###  required, resource group, subnet_name, virtual_network_name

module "azure-windows-vm" {
  source                       = "intel/azure-windows-vm/intel"
  admin_password               = var.admin_password
  azurerm_resource_group_name  = "terraform-testing-rg"
  azurerm_subnet_name          = "default"
  azurerm_virtual_network_name = "vm-vnet1"
  tags = {
    owner    = "youremail@company.com",
    duration = "5"
  }
}

