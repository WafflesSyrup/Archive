#**********************************************************************
#Author: Shane Dilling Email: 

# Purpose: This Powershell script will read the domain and

#all accounts created in 2014 start and end date

#THIS SCRIPT IS PROVIDED WITHOUT WARRANTY, USE AT YOUROWN RISK **

#***********************************************************************

# —— File location ———–
$CSVpath = “\\FileServer\TEMP\Retain1Day\2014.csv”
$Start = Get-Date -Day 01 -Month 01 -Year 2014 -Hour 00
$End = Get-Date -Day 31 -Month 12 -Year 2014 -Hour 23 -Minute 59

Get-QADUser -SearchRoot “Domain.com/Users” -createdafter $start -createdbefore $end -sizelimit 0 | Select DisplayName,WhenCreated | Export-Csv $CSVpath -NoType