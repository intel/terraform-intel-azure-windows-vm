
$service_user = $args[0]

Invoke-WebRequest -o "C:\Program Files\telegraf.exe" https://storage.googleapis.com/cbr_bucket_artifacts/Utils/Windows/telegraf.exe

Set-Location -Path "C:\Program Files"
C:\\"Program Files"\\telegraf.exe --service install --config C:\\Users\\$service_user\\telegraf.conf
C:\\"Program Files"\\telegraf.exe --service start