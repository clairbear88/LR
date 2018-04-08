[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
$A = [Microsoft.VisualBasic.Interaction]::InputBox("Ensure source file is placed into PatternConverter folder where script is located", "UserInput", "Example.txt")
$B='C:\Program Files\LogRhythm\LogRhythm Job Manager\config\list_import\'+$A
get-content .\$A | foreach-object {add-content $B "%$_%"}