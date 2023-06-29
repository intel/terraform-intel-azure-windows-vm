#function configuring_and_enabling {
#    $sql = "USE master;
#    GO
#
#    ALTER DATABASE tpcc
#    MODIFY FILE (NAME = tpcc, FILENAME = 'X:\tpcc.mdf', FILEGROWTH=8192);
#    GO"  
#    invoke-sqlcmd $sql
#    
#    $sql = "USE master;
#    GO
#    
#    ALTER DATABASE tpcc
#    MODIFY FILE (NAME = tpcc_log, FILENAME = 'Y:\tpcc_log.ldf', FILEGROWTH=8192);
#    GO"  
#    invoke-sqlcmd $sql
#    
#    # sqlcmd -S 34.172.225.119 -U sqlsample -P Sqls@1234 -Q "ALTER DATABASE tpcc  MODIFY FILE (NAME = tpcc, FILENAME = 'X:\tpcc.mdf', FILEGROWTH=8192);
#    # ALTER DATABASE tpcc  MODIFY FILE (NAME = tpcc_log, FILENAME = 'Y:\tpcc_log.ldf', FILEGROWTH=8192);"
#    Restart-Service -Force MSSQLSERVER    
#}

function configuring_and_enabling {
    $sql = "USE master;
    GO
    ALTER DATABASE tpcc
    MODIFY FILE (NAME=N'tpcc', SIZE=500GB, FILEGROWTH=8192);
    GO"  
    invoke-sqlcmd $sql
    
    $sql = "USE master;
    GO
    ALTER DATABASE tpcc
    MODIFY FILE (NAME=N'tpcc_log', SIZE=500GB, FILEGROWTH=8192);
    GO"  
    invoke-sqlcmd $sql
	
	$sql = "USE master;
    GO
    ALTER DATABASE tpcc SET RECOVERY SIMPLE
    GO"  
    invoke-sqlcmd $sql
  
    Restart-Service -Force MSSQLSERVER    
}

configuring_and_enabling