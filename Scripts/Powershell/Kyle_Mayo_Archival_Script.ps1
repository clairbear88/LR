**
# shift two tests to accept a folder to be a REGEX test instead - completed mod 11/11/2015
# restructure 10/19/2015 to allow swarm of scripts to deconflict by 0depart existance
# make logfile more structured as CSV - deal with a LM not being online (skip and log)
# longer version to deal with 0depart create and cycle through several sources on path - and maybe target dir already there

$StartDate = get-date "1/1/2015"  #LCA folders this date forward to move
$EndDate = get-date "1/9/2016" # LCA folders this date last to move
$PathDestinationBase = "R:"  # set to R: for LM to NAS 090 - trailing \ is added by script
# set to T: on EM/LM D: on SLF
# above are the control variables - ensure set before start script
$ScriptHost = Get-Content env:computername
$ScriptHost = $ScriptHost.ToLower()
if ($ScriptHost -match "roplog901a|roplog903a"){
  $LogFilePath = "T:\Temp\LCA_file_move_script_LM_activity_" + $ScriptHost + ".csv"
} else {
  $LogFilePath = "D:\Temp\LCA_file_move_script_LM_activity_" + $ScriptHost + ".csv"
}
$StartDate = $StartDate.AddMinutes(-5)
$EndDate = $EndDate.AddMinutes(5)
$DTStamp = get-date -format s # make a logfile entry (below)
New-Item $LogFilePath -type file -Force
$PathLM = "a-begin"
Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|INFO|Script starting")
Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|MSG|Starting up PowerShell script to move .LCA files via swarm - ver 3.1 Nov 2015")
Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|PARAM|script start date boundary|" + $StartDate)
Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|PARAM|script end boundary|" + $EndDate)
[bool] $erroronmove = $false
For ($LMNum=10; $LMNum -lt 42; $LMNum++)  {
  $PathLM = "lm" + $LMNum #set according to which LM is source
  $PathSourceRoot = "\\roplog0" + $LMNum + "a\D$\LogRhythmArchives\Inactive"
  $PathSource = $PathSourceRoot  # use this - comment out above - for pull from LM
  $PostActivityDestMove = $PathSource + "\0depart"
  Out-Host -InputObject ("Looking at Log Manager: " + $PathLM)
  Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|LOGMGR|Looking at next Log Manager")
  if ( -not (Test-Path $PathSource)){
    Out-Host -InputObject ("Log Manager not available: " + $PathLM)
    $DTStamp = get-date -format s # make a logfile entry (below)
    Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|LOGMGRERR**|Log Manager not available|")
  } else {
    if ( Test-Path $PostActivityDestMove){
         Out-Host -InputObject ("Log Manager semaphore already set: " + $PathLM)
      $DTStamp = get-date -format s  # make a logfile entry (below) - semaphore present so move on
      Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|SKIPLOGMGR|Busy so this script skips this LM")
       } else {
         $WaitRandom = Get-Random -Minimum 0 -Maximum 4500
         Start-Sleep -Milliseconds (500 + $WaitRandom)
         if ( Test-Path $PostActivityDestMove){
           Out-Host -InputObject ("Log Manager semaphore already set: " + $PathLM)
        $DTStamp = get-date -format s  # make a logfile entry (below) - semaphore present so move on
        Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|SKIPLOGMGR|Busy 2nd try so this script skips this LM")
         } else {
           # reserve the server by making the directory, log this and get to work
        New-Item $PostActivityDestMove -type directory
        $DTStamp = get-date -format s  # make a logfile entry (below)
        Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|DIRCREATE|Creating directory|" + $PostActivityDestMove)
              Get-ChildItem $PathSource -Recurse | % {
          if ($_.Attributes -eq "Directory"){
            $InputString = $_.Name
            $InputFullPath = $_.fullname
            $DTStamp = get-date -format s # make a logfile entry (below)
            Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|LOOKFOLDER|looking at folder|" + $InputFullPath)
            Out-Host -InputObject ("Looking at folder: " + $InputFullPath)
            if( -not ($InputFullPath.contains("\0depart"))){ # use match
              if ($InputString -match "201[5-9](0[1-9]|1[0-2])\d\d_\d{1,2}_\d{18}") {  # match works until 2020 year
                [int]$MyYear = $InputString.Substring(0,4)
                [int]$MyMonth = $InputString.Substring(4,2)
                [int]$MyDay = $InputString.Substring(6,2)
                $DateFolder = get-date -year $MyYear -month $MyMonth -day $MyDay -hour 0 -minute 0 -second 0
                if (($DateFolder -gt $StartDate) -and ($DateFolder -lt $EndDate)){
                  $DTStamp = get-date -format s  # make a logfile entry (below)
                  Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|PROCFOLDER|processing folder|" + $InputString)
                  [int]$DayNumofWeek = $DateFolder.DayOfWeek.value__
                  $BaseWeekDate = $DateFolder.AddDays(-1 * $DayNumofWeek)
                  [string]$BaseYearNum = $BaseWeekDate.Year
                  $BaseMonthNum = $BaseWeekDate.Month.ToString("00")
                  $BaseDayNum = $BaseWeekDate.Day.ToString("00")
                  $OutputMonthString = $BaseYearNum + "-" + $BaseMonthNum + "month"
                  $OutputWeekString = $BaseYearNum + "-" + $BaseMonthNum + "-" + $BaseDayNum +"week"
                  $PathOutMonth = $PathDestinationBase + "\" + $OutputMonthString
                  $PathOutWeek = $PathOutMonth + "\" + $OutputWeekString
                 $PathOutWkLM = $PathOutWeek + "\" + $PathLM
                  $DTStamp = get-date -format s  # make a logfile entry (below)
                  Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|DESTCHK|checking for dest folder|" + $PathOutMonth)
                  if ( -not (Test-Path $PathOutMonth)){
                    New-Item $PathOutMonth -type directory
                    $DTStamp = get-date -format s  # make a logfile entry (below)
                    Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|DESTMAKE|creating dest folder|" + $PathOutMonth) }
                  $DTStamp = get-date -format s  # make a logfile entry (below)
                  Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|DESTCHK|checking for dest folder|" + $PathOutWeek)
                  if ( -not (Test-Path $PathOutWeek)){
                    New-Item $PathOutWeek -type directory
                    $DTStamp = get-date -format s  # make a logfile entry (below)
                    Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|DESTMAKE|creating dest folder|" + $PathOutWeek) }
                  $DTStamp = get-date -format s  # make a logfile entry (below)
                  Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|DESTCHK|checking for dest folder|" + $PathOutWkLM)
                  if ( -not (Test-Path $PathOutWkLM)){
                    New-Item $PathOutWkLM -type directory
                    $DTStamp = get-date -format s  # make a logfile entry (below)
                    Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|DESTMAKE|creating dest folder|" + $PathOutWkLM) }
                  # enumerate the count & size contents of folder
                  $FileSpace = 0
                  $FileCount = 0
                  Get-ChildItem $InputFullPath -Recurse | foreach {
                    $FileSpace = $FileSpace + $_.length
                    $FileCount++
                  }
                  $FileSpaceMB = $FileSpace / 1MB
                  $SourceAttribString = "|" + $FileSpaceMB.ToString("N1") + "MB|" + $FileCount.ToString("N0") + "files"
                  Out-Host -InputObject ("Working the folder contains size - count: " + $SourceAttribString + " qty info.")
                  $DTStamp = get-date -format s  # make a logfile entry (below)
                  Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|FLDRSRC|source folder size - count" + $SourceAttribString)
                  $DTStamp = get-date -format s  # make a logfile entry (below)
                  Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|FLDRCOPY|beginning copy src - dst|" + $InputFullPath + "|" + $PathOutWkLM)
                  if (Test-Path ($PathOutWkLM + "\" + $InputString)) {  # dir already exists so err info
                    Out-Host -InputObject ("Folder already exists for: " + $InputFullPath)
                    $DTStamp = get-date -format s  # make a logfile entry (below)
                    Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|FLDRERR**|folder already exists - so no copy|" + $InputFullPath)
                  } else {  # dir not there so do the copy
                    Copy-Item -path $InputFullPath -destination ($PathOutWkLM + "\") -recurse
                  }
                  $DTStamp = get-date -format s  # make a logfile entry (below)
                  Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|FLDREND|copy complete (if no prior err) moving folder to|" + $PostActivityDestMove)
                  Move-Item  -path $InputFullPath -destination $PostActivityDestMove
                  $CheckDestination = $PathOutWkLM + "\" + $InputString
                  $DTStamp = get-date -format s  # make a logfile entry (below)
                  Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|FLDRDEST|checking copy destination size and count|" + $CheckDestination)
                  $FileSpace = 0
                  $FileCount = 0
                  Get-ChildItem $CheckDestination -Recurse | foreach {
                    $FileSpace = $FileSpace + $_.length
                    $FileCount++
                  }
                  $FileSpaceMB = $FileSpace / 1MB
                  $DestAttribString = "|" + $FileSpaceMB.ToString("N1") + "MB|" + $FileCount.ToString("N0") + "files"
                  $DTStamp = get-date -format s  # make a logfile entry (below)
                  Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|FLDRDESTSZ|destination folder size - count" + $DestAttribString)
                  if ($SourceAttribString -eq $DestAttribString){
                    Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|FLDRDESTGOOD|dest & src folder match TRUE")
                  } else {
                    Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|FLDRDESTBAD|dest & src folder match FALSE")
                    $erroronmove = $true
                  } # bottom of error check logic - reporting
                } #end inside date range - main working path to process
              } #name fits match REGEX "201[5-9](0[1-9]|1[0-2])\d\d_\d{1,2}_\d{18}"
            } #end is not /0depart subdirectory
          } #end is directory object
        } #end childitem recursion
         } #bottom fork second 0depart test - semaphore to work this server
       } #bottom fork first 0depart test
  } #end of dir test the LogManager is avail
} # bottom LMNum loop
$PathLM = "z-ending"
if ($erroronmove) {
  Out-Host -InputObject "Space or count error detected in files move activity - check logs"
  $DTStamp = get-date -format s  # make a logfile entry (below)
  Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|WARN|Space or count error detected in files move for this scripthost")
} else {
  $DTStamp = get-date -format s  # make a logfile entry (below)
  Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|HAPPY|No space or count error detected in files move for this scripthost")
}
Out-Host -InputObject "Script complete."
$DTStamp = get-date -format s  # make a logfile entry (below)
Add-Content $LogFilePath ($DTStamp + "|" + $ScriptHost + "|" + $PathLM + "|INFO|Script run ending")

**
For ($LMNum=10; $LMNum -lt 41; $LMNum++) {
  $Destination =  "\\roplog0" + $LMNum + "a\D$\LogRhythmArchives\Inactive\0depart"
  $DTStamp = get-date -format s
  Out-Host -InputObject ($DTStamp + ": Checking for folder tree: " + $Destination)
  if (Test-Path $Destination){
    Out-Host -InputObject ($DTStamp + ": Removing folder tree....: " + $Destination)
    Remove-Item -Recurse -Force $Destination }}

