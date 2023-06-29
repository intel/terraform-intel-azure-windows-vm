
$num_disk = $args[0]
$data_disk_num = $args[1]
$data_disk_size = $args[2]
$log_disk_num = $args[3]
$log_disk_size = $args[4]

$data_size_in_gb = $data_disk_size * '1GB'
$log_size_in_gb = $log_disk_size * '1GB'

Initialize-Disk -Number $data_disk_num

if($num_disk -ge 2) {
    Initialize-Disk -Number $log_disk_num
}

New-Partition -DiskNumber $data_disk_num -Size $data_size_in_gb -DriveLetter X | Format-Volume -FileSystem NTFS -AllocationUnitSize 65536
Set-Volume -DriveLetter 'X' -NewFileSystemLabel 'SQL Server Data'
New-Partition -DiskNumber $log_disk_num -Size $log_size_in_gb -DriveLetter Y | Format-Volume -FileSystem NTFS -AllocationUnitSize 65536
Set-Volume -DriveLetter 'Y' -NewFileSystemLabel 'SQL Server Logs'

if($num_disk -eq 3) {
    $temp_disk_num = $args[5]
    $temp_disk_size = $args[6]
    $temp_size_in_gb = $temp_disk_size * '1GB'

    Initialize-Disk -Number $temp_disk_num
    New-Partition -DiskNumber $temp_disk_num -Size $temp_size_in_gb -DriveLetter Z | Format-Volume -FileSystem NTFS -AllocationUnitSize 65536
    Set-Volume -DriveLetter 'Z' -NewFileSystemLabel 'SQL Server Logs'
}

$permission = "Everyone","FullControl","ContainerInherit,ObjectInherit","None","Allow"
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule $permission

$acl = Get-Acl X:\
$acl.SetAccessRule($accessRule)
$acl | Set-Acl X:\

$acl = Get-Acl Y:\
$acl.SetAccessRule($accessRule)
$acl | Set-Acl Y:\

if($num_disk -eq 3) {
    $acl = Get-Acl Z:\
    $acl.SetAccessRule($accessRule)
    $acl | Set-Acl Z:\
}
