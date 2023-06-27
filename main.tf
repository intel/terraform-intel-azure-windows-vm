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
  resource_group_name             = var.azurerm_resource_group_name
  size                            = var.virtual_machine_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  tags                            = var.tags

  network_interface_ids = [azurerm_network_interface.nic.id]

  os_disk {
    name                      = var.os_disk_name
    caching                   = var.os_disk_caching
    storage_account_type      = var.os_disk_storage_account_type
    disk_size_gb              = var.disk_size_gb
    write_accelerator_enabled = var.write_accelerator_enabled
  }
  
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}  

  /* source_image_reference {
    publisher = var.source_image_reference_publisher
    offer     = var.source_image_reference_offer
    sku       = var.source_image_reference_sku
    version   = var.source_image_reference_version
  } */

  /* dynamic "boot_diagnostics" {
    for_each = var.enable_boot_diagnostics ? [1] : []
    content {
      storage_account_uri = var.azurerm_storage_account_name != null ? data.azurerm_storage_account.example.0.primary_blob_endpoint : null

    }
  } */

  /* dynamic "identity" {
    for_each = var.identity != [] ? [var.identity] : []
    content {
      identity_ids = lookup(identity.value, "identity_ids", null)
      principal_id = lookup(identity.value, "principal_id", null)
      tenant_id    = lookup(identity.value, "tenant_id", null)
      type         = lookup(identity.value, "type", null)
    }
  } */