$modulePath = "$env:C:\Users\James.clair\Documents"
if(!(Test-Path $modulePath))

    New-Item -Path $modulePath -ItemType Directory