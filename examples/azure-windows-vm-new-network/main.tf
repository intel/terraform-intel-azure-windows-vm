locals {
  resource_group_name = "resource-group-test"
  location            = "West US 2"
  prefix              = "test-1"
}

resource "azurerm_resource_group" "example" {
  name     = local.resource_group_name
  location = local.location
 tags = {
    owner    = "youremail@company.com",
    duration = "5"
}
}

resource "azurerm_virtual_network" "example" {
  name                = "${local.prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "${local.prefix}-subnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "example" {
  name                = "${local.prefix}-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "${local.prefix}-nic-config"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

module "azure-windows-vm" {

  source                       = "intel/azure-windows-vm/intel"
  admin_password               = var.admin_password
  azurerm_resource_group_name  = azurerm_resource_group.example.name
  azurerm_subnet_name          = azurerm_subnet.example.name
  azurerm_virtual_network_name = azurerm_virtual_network.example.name
  tags = {
    owner    = "youremail@company.com",
    duration = "5"
  }
  depends_on = [azurerm_resource_group.example]
}

