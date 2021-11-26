Add-PSSnapin Quest.ActiveRoles.ADManagement

$disabledusers = Get-QARSOperation -SizeLimit 0 -CompletedRecently ([TimeSpan]::FromDays(700)) -AttributesChanges @{edsaAccountIsDisabled="$TRUE"} -Proxy

$disabledusers | select @{n="User";e={$_.TargetObjectInfo.DN.Replace("OU=DisabledAccounts,DC=Domain,DC=Com","").Split(",")[0]}},@{n="Initiated By";e={$_.InitiatorInfo.NTAccountName}},@{n="Date";e={$_.Initiated}} | Export-Csv C:\QUEST\Scripts\DisabledUsers.csv -NoTypeInformationexit 4