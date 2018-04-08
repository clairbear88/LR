#Purpose: Script to create temporary backups of Web console Case Indices, see CASE-1056.
#Author: James Clair
#Date: 12/20/17
#Requirements: .NET 4.5
#Comments: This script can be called by Windows Task Manager to run on a schedule.  Recommended staging location: 'C:\tmp'

$source = "C:\tmp\indices"
$exclusions = '*1F4779BA-307E-4F65-9947-3AFA882EE06B*','*4585D33E-C058-4AFA-89CE-ED2BF4B7823D*','*E3FFCBF1-7981-4916-A5AE-AAA4332D2CB5*'
$destination = "C:\tmp\Backup.zip"
$backupFolder = "C:\tmp\Backup"

#Add .NET zipfile assemblies
Add-Type -Assembly "system.io.compression.filesystem"

#If previous backup exists delete
If(Test-path $destination) {Remove-item $destination -Recurse}
If(Test-path $backupFolder) {Remove-Item $backupFolder\* -Recurse}

#Get all indexes to backup
$sourceFolders = Get-ChildItem -Path $source -Exclude $exclusions
#Write-Host $sourceFolders

#Make a backup folder
IF ((Test-path $backupFolder) -eq $False) {
    New-Item -Path $backupFolder -ItemType directory
    }

#Move all sourceFolders into backup folder
foreach ($folder in $sourceFolders) {
    Copy-Item -Path $folder -Destination $backupFolder
    } 

#Compress contents of the backup directory
[io.compression.zipfile]::CreateFromDirectory($backupFolder, $destination)

#Cleanup backupFolder
If(Test-path $backupFolder) {Remove-Item $backupFolder\* -Recurse}