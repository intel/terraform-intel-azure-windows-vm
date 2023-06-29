
$service_user = $args[0]

[Net.ServicePointManager]::SecurityProtocol= [Net.SecurityProtocolType]::Tls, [Net.SecurityProtocolType]::Tls11, [Net.SecurityProtocolType]::Tls12, [Net.SecurityProtocolType]::Ssl3

[Net.ServicePointManager]::SecurityProtocol= "Tls, Tls11, Tls12, Ssl3"

Invoke-WebRequest -Uri https://storage.googleapis.com/cbr_bucket_artifacts/Utils/Windows/OpenSSH-Win64.zip -o C:\Users\$service_user\openssh-win64.zip

expand-archive -path  C:\Users\$service_user\openssh-win64.zip -destinationpath "C:\Program Files\OpenSSH"

powershell.exe -ExecutionPolicy Bypass -File "C:\Program Files\OpenSSH\OpenSSH-Win64\install-sshd.ps1"

New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22

netsh advfirewall firewall add rule name=sshd dir=in action=allow protocol=TCP localport=22

net start sshd

Set-Service sshd -StartupType Automatic