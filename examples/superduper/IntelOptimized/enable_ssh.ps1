
function enable_ssh {
  New-NetFirewallRule -DisplayName 'Enable Port 22' -Profile 'Public' -Direction Inbound -Action Allow -Protocol TCP -LocalPort 22
  Enable-PSRemoting -Force
  Start-Service sshd
}

enable_ssh