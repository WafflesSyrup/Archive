#**********************************************************************
# Author: Shane Dilling – Senior Exchange/Active Directory Administrator
# URL:
# Date: August 2013
# THIS SCRIPT IS PROVIDED WITHOUT WARRANTY, USE AT YOUROWN RISK **
# Purpose: To notify the managers of
# Consultants/Contractors of account Expiry … messy but works 😀
#*************************************************************

# ——–Date Calculations ———
$datediff = 30
$finalNotice = 1
$DatePast = (Get-Date).AddDays($dateDiff)
$checkd = (Get-Date)

# ——– Email Address and SMTP Server ——–
$FromAddress = “admin@domain.com”
$SMTPServer = “smtprealy.domain.com”

# ——- Email Body Information ———
$a = ‘<a href=”https://ticketingSystem.domain.com”>TicketRequest</a>&#8217'
$b = ‘<p>’
$cd = ‘<b>’
$dc = ‘</b>’

# ——- Get All Expired Account(s) from Consultants OU ————#

$Expiring = Get-QADUser -SearchRoot “domain.com/ManagedUsers/Staff/Consultants” -IncludeAllProperties -AccountExpiresbefore $datePast -sizelimit 0

# ——- Loop to send an email on all Expired users or Expiring users ————
foreach ($Acct in $expiring) {
if ($acct.mail -ne $null) {
$expiration = $acct.accountexpires.tostring()
$recipients = @($acct.mail)
#$recipients = @(Get-QADUser $acct.Manager).mail
if ($acct.Manager -ne $null) {
$recipients += (Get-QADUser $acct.Manager).mail
}
if ($checkd -ge $expiration) {
#——-Body Message for accounts that expired———-
$msgBody = “The Domain Account (“+$cd+$Acct.Name+$dc+”, “+$Acct.mail+”) has expired on “+$expiration+$b+
“Please Open a ” +$a+” if you wish for this account to be extended past the listed date.”+$b+
“If the contractor or user is no longer with Company, please create an off-boarding ticket in Ticketing System.”+$b+
“Thank you”+$b+
“System Admin”

$subjecttest = “Account ” + $Acct.Name +” has Expired on ” +$expiration
Send-MailMessage -Subject $subjecttest -To $recipients -From $FromAddress -Cc “systemadmin@domain.com” -SmtpServer $SMTPServer -BodyasHTML $msgBody
}
else {
# ——— Body Message for accounts that are expiring ———-
$msgBody = “The Domain Account (“+$cd+$Acct.Name+$dc+”, “+$Acct.mail+”) expires on “+$expiration+$b+
“Please Open a ” +$a+” if you wish for this account to be extended past the listed date.”+$b+
“If the contractor or user is no longer with Company, please create an off-boarding ticket in Ticketing System”+$b+
“Thank you”+$b+
“System Admin”

$subjecttest = “Account ” + $Acct.Name +” is Expiring on ” +$expiration
Send-MailMessage -Subject $subjecttest -To $recipients -From $FromAddress -Cc “SystemAdmin@domain.com” -SmtpServer $SMTPServer -BodyasHTML $msgBody
}
}
}