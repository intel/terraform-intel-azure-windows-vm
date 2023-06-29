
$instance_memory = $args[0]

function sp_configure_sql_queries {

    $sql = "sp_configure show_advanced_options,1
    go
    RECONFIGURE WITH OVERRIDE
    go"
    invoke-sqlcmd $sql

    $sql = "sp_configure backup_compression,1
    go
    RECONFIGURE WITH OVERRIDE
    go"
    invoke-sqlcmd $sql

    $sql = "sp_configure 'default trace enabled',0
    go
    RECONFIGURE WITH OVERRIDE
    go"
    invoke-sqlcmd $sql

    $sql = "sp_configure lightweight_pooling,1
    go
    RECONFIGURE WITH OVERRIDE
    go"
    invoke-sqlcmd $sql

    $sql = "sp_configure max_degree_of_parallelism,1
    go
    RECONFIGURE WITH OVERRIDE
    go"
    invoke-sqlcmd $sql

    $sql = "sp_configure max_worker_threads,3000
    go
    RECONFIGURE WITH OVERRIDE
    go"
    invoke-sqlcmd $sql

    $sql = "sp_configure priority_boost,1
    go
    RECONFIGURE WITH OVERRIDE
    go"
    invoke-sqlcmd $sql

    $sql = "sp_configure recovery_interval,32767
    go
    RECONFIGURE WITH OVERRIDE
    go"
    invoke-sqlcmd $sql

    $sql = "sp_configure remote_query_timeout,0
    go
    RECONFIGURE WITH OVERRIDE
    go"
    invoke-sqlcmd $sql

    $sql = "sp_configure set_working_set_size,1
    go
    RECONFIGURE WITH OVERRIDE
    go"
    invoke-sqlcmd $sql

    $sql = "sp_configure network_packet_size,8192
    go
    RECONFIGURE WITH OVERRIDE
    Go"
    invoke-sqlcmd $sql
    #--- not done, as of now used the same ----
    #  for standard, for cpu 8 memory 32, 32*1024*.90 in MB
    $sql = "sp_configure max_serv, $instance_memory
    go
    RECONFIGURE WITH OVERRIDE
    go"
    invoke-sqlcmd $sql

    Restart-Service -Force MSSQLSERVER
}

function create_multiple_tempdb_files  {
    $sql = "USE [master];
    GO
    ALTER DATABASE tempdb MODIFY FILE (NAME='tempdev', SIZE=1GB, FILEGROWTH = 100);
    GO"
    invoke-sqlcmd $sql
}

function create_path {
    New-Item -ItemType File -Force -Path "Y:\MSSQL\DATA\tempdb.mdf"
    New-Item -ItemType File -Force -Path "Y:\MSSQL\DATA\templog.ldf"
    New-Item -ItemType File -Force -Path "Y:\MSSQL\DATA\tempdb_mssql_2.ndf"
    New-Item -ItemType File -Force -Path "Y:\MSSQL\DATA\tempdb_mssql_3.ndf"
    New-Item -ItemType File -Force -Path "Y:\MSSQL\DATA\tempdb_mssql_4.ndf"
}

sp_configure_sql_queries
create_multiple_tempdb_files
create_path