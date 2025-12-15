param([string] $source, [string] $target)
Function GetUserinfo_Old($Source){
$Userinfo_OLD=get-aduser $source -Properties l,st,cn,accountExpires,auxPhone2,auxPhone2typ,BuildingAbbr,BuildingCC,BuildingCity,BuildingCode,BuildingName,c,carLicense,co,company,countryCode,department,dept,deptName,displayName,divisionAbbr,divisionName,empACC,employeeNumber,extensionAttribute1,extensionAttribute10,extensionAttribute11,extensionAttribute12,extensionAttribute2,extensionAttribute4,extensionAttribute5,extensionAttribute6,extensionAttribute9,flagSUPL,givenName,globalID,initials,mail,mailNickname,manager,mobile,name,node,ntdomain,org,percomp,perloc,physicalDeliveryOfficeName,piProxyAuth,postalCode,proxyAddresses,sAMAccountName,sn,streetAddress,targetAddress,telephoneNumber,title,userAccountControl,userPrincipalName
return $Userinfo_OLD
}
Function GetUserinfo_New($Target){
$Userinfo_New=get-aduser $target -Properties l,st,cn,accountExpires,auxPhone2,auxPhone2typ,BuildingAbbr,BuildingCC,BuildingCity,BuildingCode,BuildingName,c,carLicense,co,company,countryCode,department,dept,deptName,displayName,divisionAbbr,divisionName,empACC,employeeNumber,extensionAttribute1,extensionAttribute10,extensionAttribute11,extensionAttribute12,extensionAttribute2,extensionAttribute4,extensionAttribute5,extensionAttribute6,extensionAttribute9,flagSUPL,givenName,globalID,initials,mail,mailNickname,manager,mobile,name,node,ntdomain,org,percomp,perloc,physicalDeliveryOfficeName,piProxyAuth,postalCode,proxyAddresses,sAMAccountName,sn,streetAddress,targetAddress,telephoneNumber,title,userAccountControl,userPrincipalName
return $Userinfo_New
}
Function Validateinfo($Userinfo_OLD,$Userinfo_New){
if(($Userinfo_New -ne $null) -and ($Userinfo_OLD -ne $null)){
        $validated=$true
        Set-Variable -Name $validated -Scope Global
        }
        else{$validated=$false
        }
        return $validated
}
function replacedata_1st($Userinfo_OLD,$Userinfo_NEW){
if($defineActionType1 -ne '4'){
$Filepath_Tgt="C:\Demo\Path"+$Target+"_1st.CSV"
$Filepath_Src="C:\Demo\Path"+$Source+"_1st.CSV"
CSVDE -f $Filepath_Tgt -r "(&(objectCategory=person)(objectClass=User)(SamAccountname=$Target))"
CSVDE -f $Filepath_Src -r "(&(objectCategory=person)(objectClass=User)(SamAccountname=$Source))"
}
$Userinfo_New.Displayname
$Userinfo_New.accountExpires=$Userinfo_OLD.accountExpires
$Userinfo_New.auxPhone2=$Userinfo_OLD.auxPhone2
$Userinfo_New.auxPhone2typ=$Userinfo_OLD.auxPhone2typ
$Userinfo_New.BuildingAbbr=$Userinfo_OLD.BuildingAbbr
$Userinfo_New.BuildingCC=$Userinfo_OLD.BuildingCC
$Userinfo_New.BuildingCity=$Userinfo_OLD.BuildingCity
$Userinfo_New.BuildingCode=$Userinfo_OLD.BuildingCode
$Userinfo_New.BuildingName=$Userinfo_OLD.BuildingName
$Userinfo_New.c=$Userinfo_OLD.c
$Userinfo_New.carLicense=$Userinfo_OLD.carLicense
$Userinfo_New.co=$Userinfo_OLD.co
$Userinfo_New.company=$Userinfo_OLD.company
$Userinfo_New.countryCode=$Userinfo_OLD.countryCode
$Userinfo_New.department=$Userinfo_OLD.department
$Userinfo_New.dept=$Userinfo_OLD.dept
$Userinfo_New.deptName=$Userinfo_OLD.deptName
$Userinfo_New.displayName=$Userinfo_OLD.displayName
$Userinfo_New.divisionAbbr=$Userinfo_OLD.divisionAbbr
$Userinfo_New.divisionName=$Userinfo_OLD.divisionName
$Userinfo_New.empACC=$Userinfo_OLD.empACC
$Userinfo_New.employeeNumber=$Userinfo_OLD.employeeNumber
$Userinfo_New.extensionAttribute1=$Userinfo_OLD.extensionAttribute1
$Userinfo_New.extensionAttribute10=$Userinfo_OLD.extensionAttribute10
$Userinfo_New.extensionAttribute11=$Userinfo_OLD.extensionAttribute11
$Userinfo_New.extensionAttribute12=$Userinfo_OLD.extensionAttribute12
$Userinfo_New.extensionAttribute2=$Userinfo_OLD.extensionAttribute2
$Userinfo_New.extensionAttribute4=$Userinfo_OLD.extensionAttribute4
$Userinfo_New.extensionAttribute5=$Userinfo_OLD.extensionAttribute5
$Userinfo_New.extensionAttribute6=$Userinfo_OLD.extensionAttribute6
$Userinfo_New.extensionAttribute9=$Userinfo_OLD.extensionAttribute9
$Userinfo_New.flagSUPL=$Userinfo_OLD.flagSUPL
$Userinfo_New.givenName=$Userinfo_OLD.givenName
$Userinfo_New.globalID=$Userinfo_OLD.globalID
$Userinfo_New.initials=$Userinfo_OLD.initials
$Userinfo_New.manager=$Userinfo_OLD.manager
$Userinfo_New.mobile=$Userinfo_OLD.mobile
$Userinfo_New.node=$Userinfo_OLD.node
$Userinfo_New.ntdomain=$Userinfo_OLD.ntdomain
$Userinfo_New.org=$Userinfo_OLD.org
$Userinfo_New.percomp=$Userinfo_OLD.percomp
$Userinfo_New.perloc=$Userinfo_OLD.perloc
$Userinfo_New.physicalDeliveryOfficeName=$Userinfo_OLD.physicalDeliveryOfficeName
$Userinfo_New.piProxyAuth=$Userinfo_OLD.piProxyAuth
$Userinfo_New.postalCode=$Userinfo_OLD.postalCode
$Userinfo_New.sn=$Userinfo_OLD.sn
$Userinfo_New.streetAddress=$Userinfo_OLD.streetAddress
$Userinfo_New.telephoneNumber=$Userinfo_OLD.telephoneNumber
$Userinfo_New.title=$Userinfo_OLD.title
$Userinfo_New.Displayname
Set-aduser -instance $Userinfo_New
}
Function replacedata_2nd($Userinfo_OLD,$Userinfo_NEW){
if($defineActionType1 -ne '4'){
$Filepath_Tgt="C:\Demo\Path"+$Target+"_2nd.CSV"
$Filepath_Src="C:\Demo\Path"+$Source+"_2nd.CSV"
CSVDE -f $Filepath_Tgt -r "(&(objectCategory=person)(objectClass=User)(SamAccountname=$Target))"
CSVDE -f $Filepath_Src -r "(&(objectCategory=person)(objectClass=User)(SamAccountname=$Source))"
}
$Userinfo_OLD.Displayname
$Userinfo_New.Displayname
$Userinfo_New.targetAddress=$Userinfo_OLD.targetAddress
$Userinfo_New.proxyAddresses=$Userinfo_OLD.proxyAddresses
$Userinfo_New.mailNickname=$Userinfo_OLD.mailNickname
$Userinfo_New.pager=$Userinfo_OLD.pager
$Userinfo_New.mail=$Userinfo_OLD.mail
if($defineActionType1 -ne '4'){
$Userinfo_OLD.targetAddress=$Null
$Userinfo_OLD.mailNickname=$Null
$Userinfo_OLD.mail=$Null
$Userinfo_OLD.proxyAddresses=$Null
}
$objectGUID_OLD=$Userinfo_OLD.objectGUID.Guid
$objectGUID_NEW=$Userinfo_NEW.objectGUID.Guid
$LegacyIAMUPN=$Userinfo_OLD.userPrincipalName
$LegacyIAMSAN=$Userinfo_OLD.sAMAccountName
$LegacyIAMUPN=$LegacyIAMUPN+".OLD"
$LegacyIAMSAN=$LegacyIAMSAN+".OLD"
$NewMigratedSAN=$Userinfo_OLD.sAMAccountName
$NewMigratedUPN=$Userinfo_OLD.userPrincipalName
if($defineActionType1 -ne '4'){
Set-aduser -instance $Userinfo_OLD
}
Set-aduser -instance $Userinfo_New
Set-aduser -identity $objectGUID_OLD -UserPrincipalname $LegacyIAMUPN 
Set-aduser -identity $objectGUID_NEW -UserPrincipalname $NewMigratedUPN 
Set-aduser -identity $objectGUID_OLD -samaccountname $LegacyIAMSAN 
Set-aduser -identity $objectGUID_NEW -samaccountname $NewMigratedSAN 
Rename-ADObject -Identity $objectGUID_NEW -newname $Userinfo_Old.Name
Rename-ADObject -Identity $objectGUID_OLD -newname $LegacyIAMSAN
move-adobject $objectGUID_OLD -targetpath "OU=TestUsers,DC=corp,DC=example,DC=com"
}
Function Temprequirement($Userinfo_OLD,$Userinfo_NEW){
$Userinfo_NEW.l=$Userinfo_OLD.l
$Userinfo_NEW.st=$Userinfo_OLD.st
set-aduser -Instance $Userinfo_NEW
}
Function replicateGroup($Userinfo_OLD,$Userinfo_NEW){
$Sam_Old=$Userinfo_OLD.samaccountname
$Sam_New=$Userinfo_New.samaccountname 
$groups_Old=Get-ADPrincipalGroupMembership $Sam_OLD | select samaccountname
$groups_new=Get-ADPrincipalGroupMembership $Sam_new | select samaccountname

foreach ($group in $groups_Old){
$dupcheck=$groups_new | select-string $group
if($dupcheck -eq $null){
Add-ADGroupMember -Identity $group.samaccountname -Members $Sam_New
}
}
}
Function Restore(){
    $Source_1st=Read-Host "please input the Full Path of 1st CSV file for IAM Account"
    $Source_2nd=Read-Host "please input the Full Path of 2nd CSV file for IAM Account"
    $target_1st=Read-Host "please input the Full Path of 1st CSV file for Migrated Account"
    $target_2nd=Read-Host "please input the Full Path of 2nd CSV file for Migrated Account"
    $CSV_source_IAM_1st = import-csv $Source_1st
    $CSV_source_IAM_2nd = import-csv $Source_2nd
    $CSV_source_Migrated_1st = Import-csv $target_1st
    $CSV_source_Migrated_2nd = Import-csv $target_2nd
    $userinfo_IAM=get-aduser -identity $CSV_source_IAM_1st.objectguid
    $userinfo_Migrated=get-aduser -identity $CSV_source_Migrated_1st.objectguid
    $Userinfo_OLD_1st=$CSV_source_Migrated_1st
    $Userinfo_OLD_2nd=$CSV_source_Migrated_2nd
    $Userinfo_New=$userinfo_Migrated
    $validated = Validateinfo $Userinfo_OLD_1st $Userinfo_New        
    if($validated -eq $true){
    $Userinfo_OLD = $Userinfo_OLD_1st
    replacedata_1st $Userinfo_OLD $Userinfo_NEW
        if($Source_2nd){
        $userinfo_Migrated=get-aduser -identity $CSV_source_Migrated_1st.objectguid
        $Userinfo_New=$userinfo_Migrated
        $Userinfo_OLD = $Userinfo_OLD_2nd
        $Userinfo_OLD.objectguid = $CSV_source_Migrated_1st.objectguid
        replacedata_2nd $Userinfo_OLD $Userinfo_NEW
        }
    $Sam_New=$Userinfo_NEW.SamAccountname
    Write-host "updating for $Sam_New has been done"
    }
    else{
    write-host "incorrect Target or Source Account Name"
    write-host $validated
    }
    $Userinfo_OLD_1st=$CSV_source_IAM_1st
    $Userinfo_OLD_2nd=$CSV_source_IAM_2nd
    $Userinfo_New=$userinfo_IAM
    $validated = Validateinfo $Userinfo_OLD_1st $Userinfo_New        
    if($validated -eq $true){
    $Userinfo_OLD = $Userinfo_OLD_1st
    replacedata_1st $Userinfo_OLD $Userinfo_NEW
        if($target_2nd){
        $userinfo_IAM=get-aduser -identity $CSV_source_IAM_1st.objectguid
        $Userinfo_New=$userinfo_IAM
        $Userinfo_OLD = $Userinfo_OLD_2nd
        $Userinfo_OLD.objectguid = $CSV_source_IAM_1st.objectguid
        replacedata_2nd $Userinfo_OLD $Userinfo_NEW
        }
    move-adobject $Userinfo_OLD_2nd.objectGUID.Guid -targetpath "OU=Userids,DC=corp,DC=example,DC=com"
    $Sam_New=$Userinfo_NEW.SamAccountname
    Write-host "updating for $Sam_New has been done"
    }
    else{
    write-host "incorrect Target or Source Account Name"
    write-host $validated
    }
}
Write-Host $source, $target
    $Userinfo_OLD = $null
    $Userinfo_New = $null
    
if($source){
    if($target){
    initiatedata -source $source -target $target
    if($validated -eq $true){
    replacedata_Prepare
    Write-host "update has been done"
    }
    else{
    write-host "incorrect Target or Source Account Name"
    write-host $validated
    }
    }
    else{
    write-host "there`s no input for Target Account"
    }
}
Else{
$Userinfo_OLD = $null
$Userinfo_New = $null
$defineActionType1=Read-Host "what would you do with this Script?: 
1. update User attributes for 1st Run
2. Replace User`s SamAccountName, UPN and Mail attributes for 2nd Run
3. Copy over the Group Membership
4. restore account info from CSV Backup
"
if($defineActionType1 -ne '4'){
$defineActionType2=Read-Host "choose what would you do : 
1. update attributes for only one pair of accounts 
2. update attributes for bunch of accounts 
"
Switch($defineActionType2){
1{
    $source = Read-Host "please input the SamAccontName of Source Account"
    $target = Read-Host "please input the SamAccontName of Target Account"
    #initiatedata $source $target
    $Userinfo_OLD = GetUserinfo_Old $Source
    $Userinfo_New = GetUserinfo_New $target
    $Userinfo_OLD.Displayname
    $Userinfo_New.Displayname
    $validated=$true
    if($validated -eq $true){
    Switch($defineActionType1){
    1{
    replacedata_1st $Userinfo_OLD $Userinfo_NEW
    }
    2{
    replacedata_2nd $Userinfo_OLD $Userinfo_NEW
    }
    3{
    replicateGroup $Userinfo_OLD $Userinfo_NEW
    }
    }
    $Sam_New=$Userinfo_NEW.SamAccountname
    Write-host "updating for $Sam_New has been done"
    }
    else{
    write-host "incorrect Target or Source Account Name"
    write-host $validated
    }
    }
2{
    $Path= Read-Host "Please input the Full Path of CSV File"
    $Userlist=Import-Csv $Path
    Foreach($User in $Userlist){
    $Source=$Null
    $Target=$Null
    $Source=$User.CDSID
    $Target=$User.SamAccountName
    $Userinfo_OLD = GetUserinfo_Old $Source
    $Userinfo_New = GetUserinfo_New $target    
    Set-Variable -Name $Userinfo_OLD -Scope Global
    Set-Variable -Name $Userinfo_New -Scope Global
    $validated = Validateinfo $Userinfo_OLD $Userinfo_New        
    if($validated -like $true){
        Switch($defineActionType1){
    1{
    replacedata_1st $Userinfo_OLD $Userinfo_NEW
    Temprequirement $Userinfo_OLD $Userinfo_NEW
    }
    2{
    replacedata_2nd $Userinfo_OLD $Userinfo_NEW
    }
    3{
    replicateGroup $Userinfo_OLD $Userinfo_NEW
    }
    7{
    Temprequirement $Userinfo_OLD $Userinfo_NEW
    }
    }
        $Sam_New=$Userinfo_NEW.SamAccountname
        Write-host "updating for $Sam_New has been done"
    }
    else{
    write-host "incorrect Source or Target Account Name"
    }
    }
}
9{
$Userinfo_OLD=$null
$Userinfo_new=$null
$Source=Read-Host "Input the Source ID"
$Target=Read-Host "Input the Target ID"
initiatedata $Source $Target
$Userinfo_OLD
$Userinfo_new
}
}#Switch
}
Elseif($defineActionType1 -eq '4'){
Restore
}
}