
function modify_path_of_temp_files {
    $sql = "USE master;
    GO

    ALTER DATABASE tempdb
    MODIFY FILE (NAME = tempdev, FILENAME = 'Y:\MSSQL\DATA\tempdb.mdf');
    GO

    ALTER DATABASE tempdb
    MODIFY FILE (NAME = templog, FILENAME = 'Y:\MSSQL\DATA\templog.ldf');
    GO

    ALTER DATABASE tempdb
    MODIFY FILE (NAME = temp2, FILENAME = 'Y:\MSSQL\DATA\tempdb_mssql_2.ndf');
    GO"
    invoke-sqlcmd $sql
}

function adding_three_additional_files {
    $sql = "USE [master];
    GO
    ALTER DATABASE [tempdb] ADD FILE
        (NAME = N'tempdev2', FILENAME = N'Y:\MSSQL\DATA\tempdev2.ndf', SIZE = 1GB, FILEGROWTH = 0);
    ALTER DATABASE [tempdb] ADD FILE
        (NAME = N'tempdev3', FILENAME = N'Y:\MSSQL\DATA\tempdev3.ndf', SIZE = 1GB, FILEGROWTH = 0);
    ALTER DATABASE [tempdb] ADD FILE
        (NAME = N'tempdev4', FILENAME = N'Y:\MSSQL\DATA\tempdev4.ndf', SIZE = 1GB, FILEGROWTH = 0);
    ALTER DATABASE [tempdb] ADD FILE
        (NAME = N'tempdev5', FILENAME = N'Y:\MSSQL\DATA\tempdev5.ndf', SIZE = 1GB, FILEGROWTH = 0);
    ALTER DATABASE [tempdb] ADD FILE
        (NAME = N'tempdev6', FILENAME = N'Y:\MSSQL\DATA\tempdev6.ndf', SIZE = 1GB, FILEGROWTH = 0);
    ALTER DATABASE [tempdb] ADD FILE
        (NAME = N'tempdev7', FILENAME = N'Y:\MSSQL\DATA\tempdev7.ndf', SIZE = 1GB, FILEGROWTH = 0);
    ALTER DATABASE [tempdb] ADD FILE
        (NAME = N'tempdev8', FILENAME = N'Y:\MSSQL\DATA\tempdev8.ndf', SIZE = 1GB, FILEGROWTH = 0);"
    invoke-sqlcmd $sql
    Restart-Service -Force MSSQLSERVER
}

modify_path_of_temp_files
adding_three_additional_files