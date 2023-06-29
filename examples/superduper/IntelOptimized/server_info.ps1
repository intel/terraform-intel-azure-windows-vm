
$service_user = $args[0]

Get-ComputerInfo | ConvertTo-Json -Depth 10  | Out-File -FilePath  C:\Users\$service_user\server_info.json