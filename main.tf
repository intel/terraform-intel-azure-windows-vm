##  This tf file is structured with data up top and resources below.  

data "azurerm_resource_group" "rg" {
  name = var.azurerm_resource_group_name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.azurerm_virtual_network_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "example" {
  name                 = var.azurerm_subnet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

data "azurerm_storage_account" "example" {
  count               = var.azurerm_storage_account_name != null ? 1 : 0
  name                = var.azurerm_storage_account_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_network_interface" "nic" {
  name                = var.azurerm_network_interface_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = var.azurerm_resource_group_name
  tags                = var.tags

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = data.azurerm_subnet.example.id
    private_ip_address_allocation = var.ip_configuration_private_ip_address_allocation
    public_ip_address_id          = var.ip_configuration_public_ip_address_id
  }
}


################################################################################
# Virtual Machine
################################################################################
resource "azurerm_windows_virtual_machine" "windows_vm" {
  name                = var.vm_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = var.azurerm_resource_group_name
  size                = var.virtual_machine_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  tags                = var.tags

  network_interface_ids = [azurerm_network_interface.nic.id]

  #These next three parameters are required or TDX VMs
  vtpm_enabled                    = var.tdx_flag == true ? true: null
  encryption_at_host_enabled      = var.encryption_at_host_flag == true ? true: null 
  secure_boot_enabled             = var.secure_boot_flag == true ? true: null
  zone                            = var.tdxzone_flag == true ? var.tdxzone: null
  os_disk {
    name                      = var.os_disk_name
    caching                   = var.os_disk_caching
    storage_account_type      = var.os_disk_storage_account_type
    disk_size_gb              = var.disk_size_gb
    write_accelerator_enabled = var.write_accelerator_enabled
    #This is required for TDX VM
    security_encryption_type  =  var.tdx_flag == true ? "VMGuestStateOnly": null
  }

  source_image_reference {
    publisher = var.source_image_reference_publisher
    offer     = var.source_image_reference_offer
    sku       = var.source_image_reference_sku
    version   = var.source_image_reference_version
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      identity,
    ]
  }
}  