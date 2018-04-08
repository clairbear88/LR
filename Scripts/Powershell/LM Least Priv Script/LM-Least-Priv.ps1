###Storage and Header Info###
##Directories##

$archive = "D:\LogRhythmArchives"
$LRConfigs = "C:\Program Files\LogRhythm\LogRhythm Mediator Server"

##Directory Permissions##

$inherit = [system.security.accesscontrol.InheritanceFlags]"ContainerInherit, ObjectInherit"
$propagation = [system.security.accesscontrol.PropagationFlags]"none"
$FullFileControlPrimary = "mfad\tu05857","FullControl",$inherit,$propagation,"Allow"
$FullFileControlSecondary = "mfad\tu05858","FullControl",$inherit,$propagation,"Allow"

###Literal File Path Permission Changes

# Primary Account TU05857

$acl = (Get-Item $archive).GetAccessControl('Access')
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule $FullFileControlPrimary
$acl.SetAccessRule($rule)
$acl | set-acl $archive

$acl = (Get-Item $LRConfigs).GetAccessControl('Access')
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule $FullFileControlPrimary
$acl.SetAccessRule($rule)
$acl | set-acl $LRConfigs

# Secondary Account TU05858

$acl = (Get-Item $archive).GetAccessControl('Access')
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule $FullFileControlSecondary
$acl.SetAccessRule($rule)
$acl | set-acl $archive

$acl = (Get-Item $LRConfigs).GetAccessControl('Access')
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule $FullFileControlSecondary
$acl.SetAccessRule($rule)
$acl | set-acl $LRConfigs

##Registry Permissions##

$inherit = [system.security.accesscontrol.InheritanceFlags]"ContainerInherit, ObjectInherit"
$propagation = [system.security.accesscontrol.PropagationFlags]"none"
$FullRegistryControlPrimary = "mfad\tu05857","FullControl",$inherit,$propagation,"Allow"
$FullRegistryControlSecondary = "mfad\tu05858","FullControl",$inherit,$propagation,"Allow"
$File = "C:\LogRhythm\Mayo_Permissions.txt"


# Primary Account TU05857

ForEach ($line in Get-Content ".\LM-LP-Registry.txt") {
$acl = get-acl -path $line
$rule = new-object system.security.accesscontrol.registryaccessrule $FullRegistryControlPrimary
$acl.addaccessrule($rule)
$acl|set-acl
get-acl $line | fl
Start-Sleep -s 1
}

# Secondary Account TU05858

ForEach ($line in Get-Content ".\LM-LP-Registry.txt") {
$acl = get-acl -path $line
$rule = new-object system.security.accesscontrol.registryaccessrule $FullRegistryControlSecondary
$acl.addaccessrule($rule)
$acl|set-acl
get-acl $line | fl
Start-Sleep -s 1
}