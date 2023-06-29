name                          = "cbr"
account_name                  = "test-account"

client_id                     = "xxx-xxx-xxx-xxx"
tenant_id                     = "xxx-xxx-xxx-xxx"
subscription_id               = "xxx-xxx-xxx-xxx"
client_secret                 = "xxx-xxx-xxx-xxx"

## NIC information
location                        = "eastus"
private_ip_address_allocation   = "Dynamic"
allocation_method               = "Static" #"Dynamic" #"Static" #
address_space                   = ["10.0.0.0/16"]
address_prefixes                = ["10.0.1.0/24"]
idle_timeout_in_minutes         = "10"

## security rule
priority                        = 100
direction                       = "Inbound"
access                          = "Allow"
protocol_tcp                    = "Tcp"
protocol_udp                    = "Udp"
source_port_range               = "*"
source_address_prefixes         = ["34.123.157.28/32","34.70.156.107/32","34.121.158.6/32","10.0.1.0/24"]
destination_address_prefix      = "*"
destination_tcpport_ranges      = ["22","1433","5985","5986","4022","135","1434","3389"]
destination_udpport_ranges      = ["1434"]

## VM information
client_publisher                = "MicrosoftSQLServer" # user input from experiment
client_offer                    = "sql2019-ws2019"  # user input from experiment
client_vm_size                  = "Standard_DS1_v2" # user input from experiment
client_sku                      = "standard"
client_storage_account_type     = "Standard_LRS" # Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS

server_publisher                = "MicrosoftSQLServer" # user input from experiment
server_offer                    = "sql2019-ws2019"  # user input from experiment
server_machine_type             = "Standard_DS1_v2" # https://learn.microsoft.com/en-us/azure/virtual-machines/sizes-general
server_sku                      = "standard" # Stock Keeping Unit - Specifies the SKU of the image used to create the virtual machine.
server_disk_type                = "Standard_LRS" # Possible values are either Standard_LRS, StandardSSD_LRS, Premium_LRS or (UltraSSD_LRS-is currently in preview and are not available to subscriptions)

sir_version                     = "latest" # user input from experiment
caching                         = "ReadWrite" # Possible values include None, ReadOnly and ReadWrite
create_option                   = "FromImage" # Possible values are Attach (managed disks only) and FromImage
computer_name                   = "cbr"
admin_username                  = "cbr"
admin_password                  = "Cbrtest@1234"
# disable_password_authentication = true

# Disk information
remote_data_storage_num         = 0                 # DB server remote disk count
remote_data_storage_type        = "Standard_LRS"    # DB server remote disk type - Possible values: Standard_LRS, StandardSSD_ZRS, Premium_LRS, PremiumV2_LRS, Premium_ZRS, StandardSSD_LRS or UltraSSD_LRS.
remote_data_disk_create_option  = "Empty"           #(create_option) Possible values are Import Empty Copy FromImage Restore etc..
remote_data_storage_size        = 1024              # DB server remote disk size #(disk_size_gb)
remote_data_storage_lun         = "10"              # The Logical Unit Number of the Data Disk, which needs to be unique within the Virtual Machine
remote_data_storage_caching     = "ReadWrite"       # Possible values include None, ReadOnly and ReadWrite

remote_log_storage_num          = 0
remote_log_storage_type         = "Standard_LRS"
remote_log_disk_create_option   = "Empty"
remote_log_storage_size         = 1024
remote_log_storage_lun          = "20"
remote_log_storage_caching      = "ReadWrite"

remote_temp_storage_num         = 0
remote_temp_storage_type        = "Standard_LRS"
remote_temp_disk_create_option  = "Empty"
remote_temp_storage_size        = 1024
remote_temp_storage_lun         = "30"
remote_temp_storage_caching     = "ReadWrite"