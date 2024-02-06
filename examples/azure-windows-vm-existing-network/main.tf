###  required, resource group, subnet_name, virtual_network_name
// TODO - update required section with reference to terraform.tfvars file for the 3 fields needed. 

module "azure-windows-vm" {
  source                       = "intel/azure-windows-vm/intel"
  admin_password               = var.admin_password
  azurerm_resource_group_name  = "shreejan_test_mssql"
  azurerm_subnet_name          = "dbx-public"
  azurerm_virtual_network_name = "mssql_vnet_test"
  tags = {
    owner    = "owner_name",
    duration = "5"
  }
}

