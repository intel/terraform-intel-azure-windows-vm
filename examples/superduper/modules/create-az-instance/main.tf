data "template_file" "windows-metadata" {
  template = <<EOF
    # Windows setting script
    New-NetFirewallRule -DisplayName 'Port 5985' -Profile 'Public' -Direction Inbound -Action Allow -Protocol TCP -LocalPort 5985
    Enable-PSRemoting -Force
    winrm set winrm/config/service '@{AllowUnencrypted="true"}'
    winrm set winrm/config/service/auth '@{Basic="true"}'
    #Install OpenSSH server and client
    Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
    Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
    Start-Service sshd
  EOF
}


## client creation
resource "azurerm_windows_virtual_machine" "client" {
  name                    = "${var.name}-client-${var.account_name}-${var.unique_id}"
  location                = var.region
  resource_group_name     = var.resource_group_name
  network_interface_ids   = ["${var.client_network_interface_ids}"]
  size                    = var.client_vm_size
  os_disk {
    name                  = "${var.name}-clientosdisk-${var.account_name}-${var.unique_id}"
    caching               = var.caching
    storage_account_type  = var.client_storage_account_type
  }
  source_image_reference {
    publisher = var.client_publisher
    offer     = var.client_offer
    sku       = var.client_sku
    version   = var.sir_version
  }
  computer_name                   = "cli-${var.unique_id}"
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  # disable_password_authentication = var.disable_password_authentication
  # admin_ssh_key {
  #   username   = var.admin_username
  #   public_key = file("public.pub")
  # }
}

#Enable SSH on client using powershell
resource "azurerm_virtual_machine_extension" "client_setting_script" {
  name                 = "${var.name}-client-setting-${var.account_name}-${var.unique_id}"
  virtual_machine_id   = azurerm_windows_virtual_machine.client.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<SETTINGS
  {
    "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.windows-metadata.rendered)}')) | Out-File -filepath install.ps1\" && powershell -ExecutionPolicy Unrestricted -File install.ps1"
  }
  SETTINGS
}

## server creation
resource "azurerm_windows_virtual_machine" "server" {
  name                    = "${var.name}-server-${var.account_name}-${var.unique_id}"
  location                = var.region
  resource_group_name     = var.resource_group_name
  network_interface_ids   = ["${var.server_network_interface_ids}"]
  size                    = var.server_machine_type
  os_disk {
    name                  = "${var.name}-serverosdisk-${var.account_name}-${var.unique_id}"
    caching               = var.caching
    storage_account_type  = var.server_disk_type
  }
  source_image_reference {
    publisher = var.server_publisher
    offer     = var.server_offer
    sku       = var.server_sku
    version   = var.sir_version
  }
  computer_name                   = "ser-${var.unique_id}"
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  # disable_password_authentication = var.disable_password_authentication
  # admin_ssh_key {
  #   username   = var.admin_username
  #   public_key = file("public.pub")
  # }
}

#Enable SSH on server using powershell
resource "azurerm_virtual_machine_extension" "server_setting_script" {
  name                 = "${var.name}-server-setting-${var.account_name}-${var.unique_id}"
  virtual_machine_id   = azurerm_windows_virtual_machine.server.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  protected_settings = <<SETTINGS
  {
    "commandToExecute": "powershell -command \"[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('${base64encode(data.template_file.windows-metadata.rendered)}')) | Out-File -filepath install.ps1\" && powershell -ExecutionPolicy Unrestricted -File install.ps1"
  }
  SETTINGS
}

## Create a remote storage disks
resource "azurerm_managed_disk" "data_disk" {
  count                = var.remote_data_storage_num
  name                 = "${var.name}-data-disk-${var.account_name}-${count.index}-${var.unique_id}"
  location             = var.region
  resource_group_name  = var.resource_group_name
  storage_account_type = var.remote_data_storage_type
  create_option        = var.remote_data_disk_create_option
  disk_size_gb         = var.remote_data_storage_size
}

resource "azurerm_managed_disk" "log_disk" {
  count                = var.remote_log_storage_num
  name                 = "${var.name}-log-disk-${var.account_name}-${count.index}-${var.unique_id}"
  location             = var.region
  resource_group_name  = var.resource_group_name
  storage_account_type = var.remote_log_storage_type
  create_option        = var.remote_log_disk_create_option
  disk_size_gb         = var.remote_log_storage_size
}

resource "azurerm_managed_disk" "temp_disk" {
  count                = var.remote_temp_storage_num
  name                 = "${var.name}-temp-disk-${var.account_name}-${count.index}-${var.unique_id}"
  location             = var.region
  resource_group_name  = var.resource_group_name
  storage_account_type = var.remote_temp_storage_type
  create_option        = var.remote_temp_disk_create_option
  disk_size_gb         = var.remote_temp_storage_size
}

resource "azurerm_virtual_machine_data_disk_attachment" "attach_remote_data_disk" {
  count                = var.remote_data_storage_num
  managed_disk_id      = azurerm_managed_disk.data_disk[count.index].id
  virtual_machine_id   = azurerm_windows_virtual_machine.server.id
  lun                  = count.index + var.remote_data_storage_lun
  caching              = var.remote_data_storage_caching
}

resource "azurerm_virtual_machine_data_disk_attachment" "attach_remote_log_disk" {
  count                = var.remote_log_storage_num
  managed_disk_id      = azurerm_managed_disk.log_disk[count.index].id
  virtual_machine_id   = azurerm_windows_virtual_machine.server.id
  lun                  = count.index + var.remote_log_storage_lun
  caching              = var.remote_log_storage_caching
}

resource "azurerm_virtual_machine_data_disk_attachment" "attach_remote_temp_disk" {
  count                = var.remote_temp_storage_num
  managed_disk_id      = azurerm_managed_disk.temp_disk[count.index].id
  virtual_machine_id   = azurerm_windows_virtual_machine.server.id
  lun                  = count.index + var.remote_temp_storage_lun
  caching              = var.remote_temp_storage_caching
}