#**********************************************************************
# Author: Shane Dilling – 
# URL:
# Date: August 2013
# THIS SCRIPT IS PROVIDED WITHOUT WARRANTY, USE AT YOUROWN RISK **
# Purpose: To modify division names with-in DOMAIN or any attribute on Mass
# Good for corporate Changes, addresses etc
#
#***********************************************************************
# ———— Search Domain AD for staff accounts ————-
$SearchBase = “OU=staff,ou=managed,dc=domain,dc=com”

# ———— Get all AD users with a specific Division Field ——————

$users = Get-ADUser -SearchBase $SearchBase -Filter {Division -like “Communications”}

# ———— Change all filtered users division to new Account ————–
foreach ($user in $users) {
$newDivision = “Communications and Public Affairs”
Set-ADUser -Identity $user -division $newDivision # -WhatIf
}