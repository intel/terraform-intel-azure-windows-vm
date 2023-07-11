# Example of how to pass variable for virtual machine password:
# terraform apply -var="admin_password=..."
# Environment variables can also be used https://www.terraform.io/language/values/variables#environment-variables

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
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

module "azure-windows-vm" {
  source                       = "../../"
  #source                       = "intel/azure-windows-vm/intel"
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

