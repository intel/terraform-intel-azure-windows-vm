###  required, resource group, subnet_name, virtual_network_name
// TODO - update required section with reference to terraform.tfvars file for the 3 fields needed. 

# Initialize Densify Module that will parse the densify_recommendations.auto.tfvars recommendation file
module "densify" {
  source  = "densify-dev/optimization-as-code/null"
  densify_recommendations = var.densify_recommendations
  densify_fallback        = var.densify_fallback
  densify_unique_id       = var.name
}

module "azure-windows-vm" {
  source                       = "intel/azure-windows-vm/intel"
  admin_password               = var.admin_password
  azurerm_resource_group_name  = "terraform-testing-rg"
  azurerm_subnet_name          = "default"
  azurerm_virtual_network_name = "vnet01"
  
  # ICO by Densify normal way of sizing an instance by hardcoding the size.
  #virtual_machine_size = "Standard_D4ds_v4"

  # ICO by Densify new self-optimizing instance type from Densify
  virtual_machine_size = module.densify.instance_type
  
  tags = {
    owner    = "user@company.com",
    duration = "1"
    # ICO by Densify tag instance to make it Self-Aware these tags are optional and can set as few or as many as you like.
    Name = var.name
    Current-instance-type = module.densify.current_type
    Densify-optimal-instance-type = module.densify.recommended_type
    Densify-potential-monthly-savings = module.densify.savings_estimate
    Densify-predicted-uptime = module.densify.predicted_uptime
    #Should match the densify_unique_id value as this is how Densify references the system as unique
    Densify-Unique-ID = var.name
  }
}

