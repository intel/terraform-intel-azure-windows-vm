
$num_disk = $args[0]

function setting_path_of_data_and_log {
    $sql = "USE [master]
    GO
    EXEC   xp_instance_regwrite
           N'HKEY_LOCAL_MACHINE',
           N'Software\Microsoft\MSSQLServer\MSSQLServer',
           N'DefaultData',
           REG_SZ,
           N'X:\'
    GO 

    EXEC   xp_instance_regwrite
           N'HKEY_LOCAL_MACHINE',
           N'Software\Microsoft\MSSQLServer\MSSQLServer',
           N'DefaultLog',
           REG_SZ,
           N'Y:\'
    GO"
    invoke-sqlcmd $sql
    Restart-Service -Force MSSQLSERVER
}

function setting_path_of_data_and_log_tempdb {

    $sql = "USE [master]
    GO

    EXEC   xp_instance_regwrite
           N'HKEY_LOCAL_MACHINE',
           N'Software\Microsoft\MSSQLServer\MSSQLServer',
           N'DefaultData',
           REG_SZ,
           N'X:\'
    GO

    EXEC   xp_instance_regwrite
           N'HKEY_LOCAL_MACHINE',
           N'Software\Microsoft\MSSQLServer\MSSQLServer',
           N'DefaultTemp',
           REG_SZ,
           N'Y:\'
    GO

    EXEC   xp_instance_regwrite
           N'HKEY_LOCAL_MACHINE',
           N'Software\Microsoft\MSSQLServer\MSSQLServer',
           N'DefaultLog',
           REG_SZ,
           N'Z:\'
    GO"
    invoke-sqlcmd $sql
    Restart-Service -Force MSSQLSERVER
}

if($num_disk -eq 3) {
    setting_path_of_data_and_log_tempdb
} else {
    setting_path_of_data_and_log
}
