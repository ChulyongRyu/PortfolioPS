$targets=import-csv C:\Demo\Path
$result=@()
foreach($target in $targets){
$EmpID=$target.EmpID
Write-host "updating for $EmpID"
$before=get-aduser $EmpID -Properties PasswordLastSet | select PasswordLastSet,Buildingcc,Buildingcity
$PasswordLastSet_before=$before.PasswordLastSet
$Buildingcc=$before.Buildingcc
$Buildingcity=$before.Buildingcity
Set-aduser $EmpID -ChangePasswordAtLogon:$true
$after=get-aduser $EmpID -Properties PasswordLastSet | select PasswordLastSet
$PasswordLastSet_after=$after.PasswordLastSet
$result_tmp=New-Object psobject -property @{EmpID=$EmpID;PasswordLastSet_before=$PasswordLastSet_before;PasswordLastSet_after=$PasswordLastSet_after;Buildingcc=$Buildingcc;Buildingcity=$Buildingcity}
$result+=$result_tmp
$EmpID=$null
$result_tmp=$null
$before=$null
$after=$null
$Buildingcc=$null
$Buildingcity=$null
}
$result | Export-csv C:\Demo\Path