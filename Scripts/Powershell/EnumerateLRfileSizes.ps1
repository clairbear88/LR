$OutPutFilePath = "T:\Temp\Listing_LM_SQL_dirs.csv"
New-Item $OutPutFilePath -type file -force
Add-Content $OutPutFilePath "Date-Time_examined,Server,Fork,FileName,Size_MB,CreateDT"
# enumerate the dir forks to check
$DirsToCheck = @("\D$\LogRhythm","\E$\LogRhythm","\F$\LogRhythm","\G$\LogRhythm")
For ($LMNum=10; $LMNum -lt 42; $LMNum++)  {
  Out-Host -InputObject ("Looking at Log Manager: " + $LMNum)
  $PathSourceRoot = "\\roplog0" + $LMNum + "a"
  foreach($CheckDir in $DirsToCheck) {
    $PathToCheck = $PathSourceRoot + $CheckDir
    Get-ChildItem $PathToCheck | foreach {
      $DTStamp = get-date -format s
      $ExportRow = $DTStamp + "," + $PathSourceRoot + "," + $CheckDir + ","
      $ExportRow = $ExportRow + $_.Name + "," + ($_.length/1MB) + "," + $_.creationtime
      Add-Content $OutPutFilePath $ExportRow
    }
  } # bottom fork loop
} # bottom lm (server) loop
