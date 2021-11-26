Import-module ActiveDirectory
$username = Read-Host "Please Enter in a Username"
GET-ADUser -Identity $username –Properties MemberOf | Select-Object -ExpandProperty MemberOf | Get-ADGroup -Properties name | Select-Object name > C:\Temp\MemberOf$unserame.txt
Write-Host ""
Write-Host "Output Complete, Please check C:\Temp\ folder for user output."
Write-Host ""