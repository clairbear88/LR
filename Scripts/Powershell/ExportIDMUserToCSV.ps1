<#
Author: James Clair
Date: 3/23/18
Description: Export IDMUser table to csv
#>

#import SQL Server module
Import-Module SQLPS -DisableNameChecking
#replace this with your instance name
$instanceName = "localhost"
$server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server -ArgumentList $instanceName
$dbName = "LogRhythmEMDB"
$db = $server.Databases[$dbName]
Invoke-Sqlcmd -Query "SELECT * FROM dbo.IDMUser" -ServerInstance "$instanceName" -Database $dbName | Export-Csv -LiteralPath "C:\LogRhythm\IDMUserExport.csv" -NoTypeInformation

