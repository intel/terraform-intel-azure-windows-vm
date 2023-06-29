
# Download ntrights from Artifacts
Invoke-WebRequest -o cbr_ntright.exe https://storage.googleapis.com/cbr_bucket_artifacts/Utils/Windows/ntrights.exe

#get the name of the sql server local group
$sqlgroup = net localgroup|findstr SQLServerMSSQLUser

if (!$sqlgroup) {$sqlgroup='Administrator'}

$sqlgroup=$sqlgroup.Replace('*',';')

.\cbr_ntright -u $sqlgroup +r SeLockMemoryPrivilege
.\cbr_ntright -u $sqlgroup +r SeManageVolumePrivilege