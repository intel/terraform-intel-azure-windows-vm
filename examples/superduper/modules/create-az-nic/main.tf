## create a resource group
resource "azurerm_resource_group" "resourcegroup" {
  name     = "${var.name}-rg-${var.account_name}-${var.unique_id}"
  location = var.region
}

## create a vnet
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.name}-vnet-${var.account_name}-${var.unique_id}"
  address_space       = var.address_space
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
}

## create a subnet
resource "azurerm_subnet" "subnet" {
  name                 = "${var.name}-subnet-${var.account_name}-${var.unique_id}"
  resource_group_name  = azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.address_prefixes
}

## create a client public IP
resource "azurerm_public_ip" "clientpublicip" {
  name                    = "${var.name}-client-pip-${var.account_name}-${var.unique_id}"
  location                = azurerm_resource_group.resourcegroup.location
  resource_group_name     = azurerm_resource_group.resourcegroup.name
  allocation_method       = var.allocation_method
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
}

# create a server public IP
resource "azurerm_public_ip" "serverpublicip" {
  name                    = "${var.name}-server-pip-${var.account_name}-${var.unique_id}"
  location                = azurerm_resource_group.resourcegroup.location
  resource_group_name     = azurerm_resource_group.resourcegroup.name
  allocation_method       = var.allocation_method
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
}

## create a network security group for vnet
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.name}-nsg-${var.account_name}-${var.unique_id}"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
    security_rule {
      name                       = "${var.name}-sec-rule-1-${var.account_name}-${var.unique_id}"
      priority                   = var.priority
      direction                  = var.direction
      access                     = var.access
      protocol                   = var.protocol_tcp
      source_port_range          = var.source_port_range
      source_address_prefixes    = var.source_address_prefixes
      destination_address_prefix = var.destination_address_prefix
      destination_port_ranges    = var.destination_tcpport_ranges
    }
    security_rule {
      name                       = "${var.name}-sec-rule-2-${var.account_name}-${var.unique_id}"
      priority                   = 101
      direction                  = var.direction
      access                     = var.access
      protocol                   = var.protocol_udp
      source_port_range          = var.source_port_range
      source_address_prefixes    = var.source_address_prefixes
      destination_address_prefix = var.destination_address_prefix
      destination_port_ranges    = var.destination_udpport_ranges
    }

}

## create a client network interface card 
resource "azurerm_network_interface" "clientnic" {
  name                = "${var.name}-clientnic-${var.account_name}-${var.unique_id}"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  ip_configuration {
    name                          = "${var.name}-clientip-${var.account_name}-${var.unique_id}"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = "${azurerm_public_ip.clientpublicip.id}"
  }
}

## create a server network interface card 
resource "azurerm_network_interface" "servernic" {
  name                = "${var.name}-servernic-${var.account_name}-${var.unique_id}"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  ip_configuration {
    name                          = "${var.name}-serverip-${var.account_name}-${var.unique_id}"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = "${azurerm_public_ip.serverpublicip.id}"
  }
}

## create a security group association for client
resource "azurerm_network_interface_security_group_association" "clientnetworksec" {
  network_interface_id      = "${azurerm_network_interface.clientnic.id}"
  network_security_group_id = azurerm_network_security_group.nsg.id
}

## create a security group association for server
resource "azurerm_network_interface_security_group_association" "servernetworksec" {
    network_interface_id      = "${azurerm_network_interface.servernic.id}"
    network_security_group_id = azurerm_network_security_group.nsg.id
}