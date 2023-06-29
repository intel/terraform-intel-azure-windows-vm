
$userName = "sqlserver"
$dbName = "tpcc"
$password = "Cbr!1234"


function create_user_func {
    $userName = $userName
    $dbName = $dbName
    $password = $password

    $sql = "create login [$userName] with password = '$password'; create database [$dbName]; alter authorization on database::[$dbName] to [$userName];"
    $sql
    invoke-sqlcmd $sql

    $sql = "EXEC xp_instance_regwrite N'HKEY_LOCAL_MACHINE',
    N'Software\Microsoft\MSSQLServer\MSSQLServer', N'LoginMode', REG_DWORD, 2"
    $sql
    invoke-sqlcmd $sql

    $sql = "ALTER SERVER ROLE [sysadmin]
            ADD MEMBER $userName
            GO"
    $sql
    invoke-sqlcmd $sql

    $sql = "ALTER SERVER ROLE [diskadmin]
            ADD MEMBER $userName
            GO"
    $sql
    invoke-sqlcmd $sql

    $sql = "ALTER SERVER ROLE [dbcreator]
            ADD MEMBER $userName
            GO"
    $sql
    invoke-sqlcmd $sql

    Restart-Service -Force MSSQLSERVER
}

create_user_func