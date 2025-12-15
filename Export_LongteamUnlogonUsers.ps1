$current=get-date
$Condition=$current.AddDays(-30)
$searchbase="ou=Accounts,OU=SITE-5129,ou=america,DC=corp,DC=example,DC=com"
Get-ADuser -SearchBase $searchbase -Properties lastlogondate,passwordlastset | where {$_.lastlogondate -lt "1/Aug/2023"}