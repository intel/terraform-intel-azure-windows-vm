
function firewall_disable {
    Set-NetFirewallProfile -Profile Public -Enabled False
    Set-NetFirewallProfile -Profile Private -Enabled False
}

function windows_defender {
    Remove-WindowsFeature -Name Windows-Defender
}

function power_profile {
    Get-WmiObject -Class Win32_PowerPlan -Namespace root\cimv2\power -Filter "ElementName= 'High Performance'" | Invoke-WmiMethod -Name Activate
    powercfg.exe -SETACTIVE 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    $exe = "C:\Windows\system32\powercfg.exe"
    $arguments = "-x -standby-timeout-ac 0"
    $proc = [Diagnostics.Process]::Start($exe, $arguments)
    $proc.WaitForExit()
}

function virtual_memory {
    $computerSystem = Get-WmiObject -Class Win32_ComputerSystem -EnableAllPrivileges
    $computerSystem.AutomaticManagedPagefile = $false
    $computerSystem.Put() | Out-Null
    $pageFileSetting = Get-WmiObject -Class Win32_PageFileSetting
    $pageFileSetting.InitialSize = 4096
    $pageFileSetting.MaximumSize = 4096
    $pageFileSetting.Put() | Out-Null
}

function visual_performance_func {
    $RegKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects"
    Set-ItemProperty -Path $RegKey -Name VisualFXSetting -Type DWORD -Value 2
}

firewall_disable
windows_defender
power_profile
virtual_memory
visual_performance_func