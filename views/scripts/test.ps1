vars @{
    title = 'Meh 222'
    date = "2020-01-01"
 }
 
$service = Get-Service -Name Sens,wsearch,wscsvc | Select-Object -Property DisplayName,Status,StartType
ConvertTo-PSHTMLTable -Object $service
