###  required, resource group, subnet_name, virtual_network_name
// TODO - update required section with reference to terraform.tfvars file for the 3 fields needed. 

# Initialize Kubex Module that will parse the Kubex_recommendations.auto.tfvars recommendation file
module "Kubex" {
  source  = "Kubex-dev/optimization-as-code/null"
  Kubex_recommendations = var.Kubex_recommendations
  Kubex_fallback        = var.Kubex_fallback
  Kubex_unique_id       = var.name
}

module "azure-windows-vm" {
  source                       = "intel/azure-windows-vm/intel"
  admin_password               = var.admin_password
  azurerm_resource_group_name  = "terraform-testing-rg"
  azurerm_subnet_name          = "default"
  azurerm_virtual_network_name = "vm-vnet1"
  
  # ICO by Kubex normal way of sizing an instance by hardcoding the size.
  #virtual_machine_size = "Standard_D4ds_v6"

  # ICO by Kubex new self-optimizing instance type from Kubex
  virtual_machine_size = module.Kubex.instance_type
  
  tags = {
    owner    = "youremail@company.com",
    duration = "1"
    # ICO by Kubex tag instance to make it Self-Aware these tags are optional and can set as few or as many as you like.
    Name = var.name
    Current-instance-type = module.Kubex.current_type
    Kubex-optimal-instance-type = module.Kubex.recommended_type
    Kubex-potential-monthly-savings = module.Kubex.savings_estimate
    Kubex-predicted-uptime = module.Kubex.predicted_uptime
    #Should match the Kubex_unique_id value as this is how Kubex references the system as unique
    Kubex-Unique-ID = var.name
  }
}

