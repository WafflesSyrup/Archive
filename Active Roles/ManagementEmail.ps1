#**********************************************************************
# Author: Shane Dilling Email: 
# Purpose: This Powershell (gui) script will read the domain and
# Report Consultants usually who are Expiring or Expired within 30days.
# Then email to result to “All-AccountExpirationNotification@domain.com”
#THIS SCRIPT IS PROVIDED WITHOUT WARRANTY, USE AT YOUROWN RISK
# Scheduled Task: 
#
#***********************************************************************

# ——– Email information ————

$SMTPServer = “SMTP00.Domain.com”
$From = “domainadmin@domain.com”
$To = “All-AccountExpirationNotification@domain.com”
$Subject = “Expiring or Expired Accounts”
# ——– 30 days Expiration Difference ——–
$datediff = 30
$finalNotice = 1
$DatePast = (Get-Date).AddDays($dateDiff)

# —— Temp file location ————-
$CSVpath = “\\FileServer\Temp\Retain1Day\Domain_ExpiringAccounts.csv”

# ——– Command to get all consultants who have expired and are expiring in 30 days ————
$Expiring = Get-QADUser -SearchRoot “domain.com/ManagedUsers/Consultants” -IncludeAllProperties -AccountExpiresbefore $datePast -sizelimit 0 |Sort AccountExpires |Select Name, AccountExpires, AccountExpirationStatus, @{ Label =’Manager’;Expression={(get-QADuser $_.Manager).DisplayName}} | Export-Csv $CSVpath -NoTypeInformation

# ——– Complies Email for sending CSV attachment ———
Send-MailMessage -To $To -From $From -Subject $Subject -SmtpServer $SMTPServer -Body (“Auto generated,Consultant Expiring or Expired Accounts. Sent out every 2nd Monday.”) -attachments $CSVpath

# —— Deletes Temp file ——-
Remove-Item -path $CSVpath