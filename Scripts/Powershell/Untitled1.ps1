[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') #Load visual basic modules
$A= [Microsoft.VisualBasic.Interaction]::InputBox("Input the desired action of 'Start', 'Stop', or 'Restart' to be performed on all mediator services", "UserInput") #Present form for userinput to define desired action to mediator service
if ($A -eq "Start") {Get-Content C:\LogRhythm\LM_List.txt | ForEach-Object {Get-Service -ComputerName $_ -Name scmedsvr}} #Start Services on all LM_List.txt
if ($A -eq "Stop") {Get-Content C:\LogRhythm\LM_List.txt | ForEach-Object {Get-Service -ComputerName $_ -Name scmedsvr}} #Stop Services on all LM_List.txt
if ($A -eq "Restart") {Get-Content C:\LogRhythm\LM_List.txt | ForEach-Object {Get-Service -ComputerName $_ -Name scmedsvr}} #Restart Services on all LM_List.txt
Get-Content C:\LogRhythm\LM_List.txt | ForEach-Object {Get-Service -Computername $_ -Name scmedsvr} | Out-File c:\LogRhythm\Results.txt #Note: For each item in LM_List.txt get state of service after actions performed above.

#Note: LM_List.txt is a file containing hostnames of LMs that reside in the Enclave.  This List is manually maintained for now, but may be a dynamic sql call in the future.