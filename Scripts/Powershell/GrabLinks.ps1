$Grab = New-Object -ComObject InternetExplorer.Application
$Grab.visible=$true
$Grab.navigate2('https://mcpm.mayo.edu/pwcweb/Systems.asp')
while($Grab.Busy) {Start-Sleep 10}
$Grab.Document.getElementsByTagName('A') | where {$_.ButtonLink -match 'log', 'LOG'}| Out-File .\links.txt
