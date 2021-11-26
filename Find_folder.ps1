Format CSV with COMPUTERNAME at the top and list computers from there…

example:
COMPUTERNAME
A000123
A000124
A000125

$folderPath = ‘C$\SomeFolder’
$Serverlist = Import-Csv c:\TestCSV.csv
foreach($DeviceName in $Serverlist )
{
              #echo $DeviceName.ComputerName
              if((Test-path -Path \\$($DeviceName.ComputerName)\$folderPath) -eq $FALSE)
              {
                       Write-Host $DeviceName.ComputerName “The folder does not exist.”
              }
              else
              {
                      Write-Host $DeviceName.ComputerName “The folder exists.”
              }

}