
function drop_tpcc {
    $sql = "ALTER DATABASE tpcc SET OFFLINE;
            DROP DATABASE tpcc;
            GO"
    $sql
    invoke-sqlcmd $sql
    Restart-Service -Force MSSQLSERVER
}

drop_tpcc
